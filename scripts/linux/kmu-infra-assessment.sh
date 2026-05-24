#!/bin/bash

REPORT_DIR="reports"
REPORT_FILE="$REPORT_DIR/kmu-infra-assessment-$(hostname)-$(date +%Y-%m-%d_%H-%M).txt"

mkdir -p "$REPORT_DIR"

{
echo "=================================================="
echo " KMU Infrastructure Basic Technical Assessment"
echo "=================================================="
echo "Host: $(hostname)"
echo "Date: $(date)"
echo "User: $(whoami)"
echo ""

echo "================ SYSTEM ================="
uname -a
echo ""
lsb_release -a 2>/dev/null || cat /etc/os-release
echo ""

echo "================ CPU / RAM ================="
lscpu | grep -E "Model name|CPU\\(s\\)|Architecture"
echo ""
free -h
echo ""

echo "================ DISK ================="
df -h
echo ""
lsblk
echo ""

echo "================ NETWORK INTERFACES ================="
ip addr
echo ""

echo "================ ROUTING ================="
ip route
echo ""

echo "================ DNS ================="
cat /etc/resolv.conf
echo ""

echo "================ OPEN LOCAL PORTS ================="
ss -tulpen 2>/dev/null || ss -tuln
echo ""

echo "================ FIREWALL ================="
sudo ufw status verbose 2>/dev/null || echo "ufw not available or no sudo permission"
echo ""

echo "================ SERVICES ================="
systemctl list-units --type=service --state=running --no-pager
echo ""

echo "================ INSTALLED PACKAGES COUNT ================="
dpkg -l | wc -l 2>/dev/null || echo "dpkg not available"
echo ""

echo "================ DOCKER ================="
docker ps 2>/dev/null || echo "Docker not available or no permission"
echo ""

echo "================ VIRTUALIZATION ================="
systemd-detect-virt 2>/dev/null || echo "No virtualization info"
echo ""

echo "================ SECURITY NOTES ================="
echo "- Check open ports"
echo "- Check firewall status"
echo "- Check backup strategy"
echo "- Check MFA for admin access"
echo "- Check patch management"
echo "- Check network segmentation"

} > "$REPORT_FILE"

echo "Report created:"
echo "$REPORT_FILE"
