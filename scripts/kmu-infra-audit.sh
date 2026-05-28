#!/bin/bash

################################################################################
# KMU Infrastructure Audit Script
# 
# Safely collects Linux infrastructure information for analysis.
# Generates both human-readable and JSON output.
#
# Usage: ./kmu-infra-audit.sh [--json] [--output FILE]
# 
# Security: Read-only operations. No destructive commands. No credential collection.
################################################################################

set -euo pipefail

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Default output format
OUTPUT_FORMAT="text"
OUTPUT_FILE=""
TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

# Parse command line arguments
while [[ $# -gt 0 ]]; do
  case $1 in
    --json)
      OUTPUT_FORMAT="json"
      shift
      ;;
    --output)
      OUTPUT_FILE="$2"
      shift 2
      ;;
    *)
      echo "Unknown option: $1"
      exit 1
      ;;
  esac
done

################################################################################
# System Information Collection
################################################################################

collect_system_info() {
  local hostname=$(hostname)
  local kernel=$(uname -r)
  local os=$(lsb_release -ds 2>/dev/null || echo "Unknown")
  local uptime=$(uptime -p 2>/dev/null || uptime)
  local cpu_cores=$(nproc)
  local cpu_model=$(lscpu | grep "Model name" | cut -d: -f2 | xargs)
  local memory_total=$(free -h | awk '/^Mem:/ {print $2}')
  local memory_used=$(free -h | awk '/^Mem:/ {print $3}')
  
  cat <<EOF
{
  "system": {
    "hostname": "$hostname",
    "kernel": "$kernel",
    "os": "$os",
    "uptime": "$uptime",
    "cpu": {
      "cores": $cpu_cores,
      "model": "$cpu_model"
    },
    "memory": {
      "total": "$memory_total",
      "used": "$memory_used"
    }
  }
}
EOF
}

################################################################################
# Network Configuration Analysis
################################################################################

collect_network_info() {
  local interfaces=$(ip -br link | awk '{print $1}' | grep -v "^lo$")
  local dns=$(cat /etc/resolv.conf 2>/dev/null | grep "^nameserver" | awk '{print $2}' | jq -R . | jq -s .)
  
  local network_json="{"
  network_json+="\"interfaces\": ["
  
  local first=true
  while IFS= read -r iface; do
    if [ -z "$iface" ]; then continue; fi
    
    if [ "$first" = true ]; then
      first=false
    else
      network_json+=","
    fi
    
    local ip=$(ip -4 addr show "$iface" 2>/dev/null | grep -oP '(?<=inet\s)\d+(\.\d+){3}' | head -1 || echo "")
    local mac=$(ip link show "$iface" | grep -oP '(?<=link/ether\s)[^ ]+' || echo "")
    local status=$(ip link show "$iface" | grep -oP '(?<=<)[^>]+' | head -1 || echo "")
    
    network_json+="{\"name\":\"$iface\",\"ip\":\"$ip\",\"mac\":\"$mac\",\"status\":\"$status\"}"
  done <<< "$interfaces"
  
  network_json+="]"
  network_json+=",\"dns\":$dns"
  network_json+="}"
  
  echo "$network_json"
}

################################################################################
# Open Ports Analysis
################################################################################

collect_open_ports() {
  local ports_json="["
  
  if command -v ss &> /dev/null; then
    local ports=$(ss -tuln 2>/dev/null | grep LISTEN | awk '{print $4}' | awk -F: '{print $(NF)}' | sort -u)
  elif command -v netstat &> /dev/null; then
    local ports=$(netstat -tuln 2>/dev/null | grep LISTEN | awk '{print $4}' | awk -F: '{print $(NF)}' | sort -u)
  else
    local ports=""
  fi
  
  local first=true
  while IFS= read -r port; do
    if [ -z "$port" ]; then continue; fi
    
    if [ "$first" = true ]; then
      first=false
    else
      ports_json+=","
    fi
    
    ports_json+="\"$port\""
  done <<< "$ports"
  
  ports_json+="]"
  echo "$ports_json"
}

################################################################################
# Docker Environment Detection
################################################################################

collect_docker_info() {
  local docker_json="{"
  
  if command -v docker &> /dev/null; then
    docker_json+="\"installed\":true,"
    
    local version=$(docker --version 2>/dev/null | cut -d' ' -f3 | cut -d',' -f1 || echo "unknown")
    docker_json+="\"version\":\"$version\","
    
    if docker ps &>/dev/null 2>&1; then
      local running=$(docker ps -q 2>/dev/null | wc -l)
      local total=$(docker ps -aq 2>/dev/null | wc -l)
      docker_json+="\"running_containers\":$running,"
      docker_json+="\"total_containers\":$total"
    else
      docker_json+="\"running_containers\":0,"
      docker_json+="\"total_containers\":0"
    fi
  else
    docker_json+="\"installed\":false"
  fi
  
  docker_json+="}"
  echo "$docker_json"
}

################################################################################
# Firewall Status
################################################################################

collect_firewall_status() {
  local firewall_json="{"
  
  if command -v ufw &> /dev/null; then
    local ufw_status=$(sudo ufw status 2>/dev/null | head -1 || echo "unknown")
    firewall_json+="\"ufw\":\"$ufw_status\","
  fi
  
  if command -v firewall-cmd &> /dev/null; then
    local fw_status=$(sudo firewall-cmd --state 2>/dev/null || echo "unknown")
    firewall_json+="\"firewalld\":\"$fw_status\""
  else
    firewall_json+="\"firewalld\":\"not installed\""
  fi
  
  firewall_json+="}"
  echo "$firewall_json"
}

################################################################################
# System Updates Status
################################################################################

collect_updates_status() {
  local updates_json="{"
  
  if command -v apt &> /dev/null; then
    apt update &>/dev/null 2>&1 || true
    local updates=$(apt list --upgradable 2>/dev/null | grep -c upgradable || echo 0)
    updates_json+="\"package_manager\":\"apt\","
    updates_json+="\"available_updates\":$updates"
  elif command -v yum &> /dev/null; then
    local updates=$(yum check-update 2>/dev/null | tail -1 | awk '{print $1}' || echo 0)
    updates_json+="\"package_manager\":\"yum\","
    updates_json+="\"available_updates\":$updates"
  else
    updates_json+="\"package_manager\":\"unknown\","
    updates_json+="\"available_updates\":0"
  fi
  
  updates_json+="}"
  echo "$updates_json"
}

################################################################################
# Disk Usage Analysis
################################################################################

collect_disk_usage() {
  local disk_json="["
  
  local devices=$(df -h | tail -n +2 | awk '{print $1}')
  local first=true
  
  while IFS= read -r device; do
    if [ -z "$device" ]; then continue; fi
    
    local usage=$(df -h "$device" 2>/dev/null | tail -1)
    local total=$(echo "$usage" | awk '{print $2}')
    local used=$(echo "$usage" | awk '{print $3}')
    local percent=$(echo "$usage" | awk '{print $5}')
    local mount=$(echo "$usage" | awk '{print $6}')
    
    if [ "$first" = true ]; then
      first=false
    else
      disk_json+=","
    fi
    
    disk_json+="{\"device\":\"$device\",\"total\":\"$total\",\"used\":\"$used\",\"percent\":\"$percent\",\"mount\":\"$mount\"}"
  done <<< "$devices"
  
  disk_json+="]"
  echo "$disk_json"
}

################################################################################
# Text Output Format
################################################################################

print_text_report() {
  local system_info=$(collect_system_info)
  local hostname=$(echo "$system_info" | jq -r '.system.hostname')
  
  echo ""
  echo -e "${BLUE}╔════════════════════════════════════════════════════════════════╗${NC}"
  echo -e "${BLUE}║${NC}     KMU Infrastructure Audit Report                        ${BLUE}║${NC}"
  echo -e "${BLUE}╚════════════════════════════════════════════════════════════════╝${NC}"
  echo ""
  echo -e "${YELLOW}System Information${NC}"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo "$system_info" | jq -r '.system | to_entries | .[] | "\(.key): \(.value)"'
  echo ""
  
  echo -e "${YELLOW}Network Configuration${NC}"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  collect_network_info | jq '.interfaces[] | "\(.name): \(.ip) (\(.status))"' -r
  echo ""
  
  echo -e "${YELLOW}Open Ports${NC}"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  collect_open_ports | jq '.[]' -r | tr '\n' ' '
  echo ""
  echo ""
  
  echo -e "${YELLOW}Docker Environment${NC}"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  collect_docker_info | jq 'to_entries | .[] | "\(.key): \(.value)"' -r
  echo ""
  
  echo -e "${YELLOW}Disk Usage${NC}"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  collect_disk_usage | jq '.[] | "\(.mount): \(.used) / \(.total) (\(.percent))"' -r
  echo ""
  
  echo -e "${YELLOW}Firewall Status${NC}"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  collect_firewall_status | jq 'to_entries | .[] | "\(.key): \(.value)"' -r
  echo ""
  
  echo -e "${YELLOW}Updates Status${NC}"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  collect_updates_status | jq 'to_entries | .[] | "\(.key): \(.value)"' -r
  echo ""
  
  echo -e "${GREEN}✓ Audit completed successfully${NC}"
  echo ""
}

################################################################################
# JSON Output Format
################################################################################

print_json_report() {
  local system_info=$(collect_system_info)
  local network_info=$(collect_network_info)
  local open_ports=$(collect_open_ports)
  local docker_info=$(collect_docker_info)
  local firewall_status=$(collect_firewall_status)
  local updates_status=$(collect_updates_status)
  local disk_usage=$(collect_disk_usage)
  
  local full_report=$(jq -n \
    --argjson system "$system_info" \
    --argjson network "$network_info" \
    --argjson ports "$open_ports" \
    --argjson docker "$docker_info" \
    --argjson firewall "$firewall_status" \
    --argjson updates "$updates_status" \
    --argjson disk "$disk_usage" \
    --arg timestamp "$TIMESTAMP" \
    '{
      audit: {
        timestamp: $timestamp,
        script_version: "1.0.0"
      },
      data: {
        system: $system.system,
        network: $network,
        ports: $ports,
        docker: $docker,
        firewall: $firewall,
        updates: $updates,
        disk: $disk
      }
    }')
  
  echo "$full_report"
}

################################################################################
# Main Execution
################################################################################

main() {
  # Verify required tools
  if ! command -v jq &> /dev/null; then
    echo -e "${RED}Error: jq is required but not installed${NC}"
    echo "Install with: sudo apt install jq"
    exit 1
  fi
  
  # Generate output
  if [ "$OUTPUT_FORMAT" = "json" ]; then
    local output=$(print_json_report)
  else
    print_text_report
    local output=""
  fi
  
  # Save to file if specified
  if [ -n "$OUTPUT_FILE" ]; then
    if [ "$OUTPUT_FORMAT" = "json" ]; then
      echo "$output" > "$OUTPUT_FILE"
      echo -e "${GREEN}✓ JSON audit saved to: $OUTPUT_FILE${NC}"
    else
      echo "Error: --output requires --json format"
      exit 1
    fi
  else
    if [ "$OUTPUT_FORMAT" = "json" ]; then
      echo "$output"
    fi
  fi
}

main "$@"
