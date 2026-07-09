#!/bin/bash

# ==============================================================================
# KMU Infrastructure Audit Script
# ==============================================================================
# Purpose: Safe, read-only infrastructure audit for Linux systems.
# Supported: Ubuntu 24.04, Linux Mint
# Security: No destructive commands, no credential collection, no priv-esc.
# ==============================================================================

set -u

# Configuration
REPORT_DIR="reports"
JSON_OUTPUT=false
RUN_AUDIT=true

# Help function
show_help() {
    echo "Usage: $0 [options]"
    echo ""
    echo "Options:"
    echo "  --json      Output in JSON format"
    echo "  --help      Show this help message"
}

# Parse arguments
for arg in "$@"; do
    case $arg in
        --json)
            JSON_OUTPUT=true
            ;;
        --help)
            show_help
            RUN_AUDIT=false
            ;;
    esac
done

# --- Audit Functions ---

get_system_info() {
    local hostname=$(hostname)
    local os_version=$(lsb_release -ds 2>/dev/null || grep PRETTY_NAME /etc/os-release | cut -d'"' -f2)
    local kernel=$(uname -r)
    local uptime=$(uptime -p)
    local virt=$(systemd-detect-virt 2>/dev/null || echo "none")

    if [ "$JSON_OUTPUT" = true ]; then
        echo "  \"system\": {"
        echo "    \"hostname\": \"$hostname\","
        echo "    \"os_version\": \"$os_version\","
        echo "    \"kernel_version\": \"$kernel\","
        echo "    \"uptime\": \"$uptime\","
        echo "    \"virtualization\": \"$virt\""
        echo "  }"
    else
        echo "=== SYSTEM ==="
        echo "Hostname: $hostname"
        echo "OS:       $os_version"
        echo "Kernel:   $kernel"
        echo "Uptime:   $uptime"
        echo "Virt:     $virt"
        echo ""
    fi
}

get_resources() {
    local cpu_model=$(lscpu | grep "Model name" | sed 's/Model name:[[:space:]]*//' | head -n 1)
    local cpu_cores=$(nproc)
    local mem_total=$(free -h | grep Mem | awk '{print $2}')
    local mem_used=$(free -h | grep Mem | awk '{print $3}')
    local disk_usage=$(df -h / | tail -n 1 | awk '{print $5}')

    if [ "$JSON_OUTPUT" = true ]; then
        echo "  \"resources\": {"
        echo "    \"cpu_model\": \"$cpu_model\","
        echo "    \"cpu_cores\": $cpu_cores,"
        echo "    \"memory_total\": \"$mem_total\","
        echo "    \"memory_used\": \"$mem_used\","
        echo "    \"root_disk_usage\": \"$disk_usage\""
        echo "  }"
    else
        echo "=== RESOURCES ==="
        echo "CPU:    $cpu_model ($cpu_cores cores)"
        echo "RAM:    $mem_used / $mem_total"
        echo "Disk /: $disk_usage"
        echo ""
    fi
}

get_network() {
    local ports=$(ss -tuln | grep LISTEN | awk '{print $5}' | rev | cut -d: -f1 | rev | sort -u | tr '\n' ',' | sed 's/,$//')
    local ports_json=""
    if [ -n "$ports" ]; then
        ports_json=$(echo "$ports" | sed 's/,/", "/g' | sed 's/^/"/' | sed 's/$/"/')
    fi

    if [ "$JSON_OUTPUT" = true ]; then
        echo "  \"network\": {"
        echo "    \"listening_ports\": [$ports_json]"
        echo "  }"
    else
        echo "=== NETWORK ==="
        echo "Listening Ports: $ports"
        echo "Interfaces:"
        ip -br addr 2>/dev/null || ip addr
        echo ""
    fi
}

get_docker() {
    local docker_installed=false
    local docker_version="none"
    local docker_containers=0

    if command -v docker >/dev/null 2>&1; then
        docker_installed=true
        docker_version=$(docker version --format '{{.Server.Version}}' 2>/dev/null || echo "unprivileged")
        docker_containers=$(docker ps -q 2>/dev/null | wc -l || echo "0")
    fi

    if [ "$JSON_OUTPUT" = true ]; then
        echo "  \"docker\": {"
        echo "    \"installed\": $docker_installed,"
        echo "    \"version\": \"$docker_version\","
        echo "    \"running_containers\": $docker_containers"
        echo "  }"
    else
        echo "=== DOCKER ==="
        echo "Installed: $docker_installed"
        echo "Version:   $docker_version"
        echo "Running:   $docker_containers"
        echo ""
    fi
}

get_security() {
    local ufw_status=$(sudo ufw status 2>/dev/null | head -n 1 | awk '{print $2}')
    ufw_status=${ufw_status:-"unknown/inactive"}
    local updates=$(apt list --upgradable 2>/dev/null | grep -c upgradable || echo "0")

    if [ "$JSON_OUTPUT" = true ]; then
        echo "  \"security\": {"
        echo "    \"firewall_status\": \"$ufw_status\","
        echo "    \"pending_updates\": $updates"
        echo "  }"
    else
        echo "=== SECURITY ==="
        echo "Firewall: $ufw_status"
        echo "Updates:  $updates pending"
        echo ""
    fi
}

# --- Execution ---

if [ "$RUN_AUDIT" = true ]; then
    if [ "$JSON_OUTPUT" = true ]; then
        echo "{"
        get_system_info
        echo ","
        get_resources
        echo ","
        get_network
        echo ","
        get_docker
        echo ","
        get_security
        echo "}"
    else
        echo "KMU Infrastructure Audit Report"
        echo "Generated: $(date)"
        echo "--------------------------------------------------"
        get_system_info
        get_resources
        get_network
        get_docker
        get_security
    fi
fi
