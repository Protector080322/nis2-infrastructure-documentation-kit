#!/bin/bash

mkdir -p diagrams

cat > diagrams/kmu-enterprise-architecture.mmd <<'EOF'
flowchart TD

    Internet((Internet))
    DNS[External DNS / Domain]
    Mail[Microsoft 365 / Exchange Online]
    Entra[Microsoft Entra ID / MFA]

    Internet --> FW[Next-Gen Firewall / UTM]
    DNS --> FW
    FW --> VPN[Remote Access VPN]
    FW --> DMZ[DMZ Network]

    DMZ --> WAF[Reverse Proxy / WAF]
    DMZ --> Web[Public Web Services]

    FW --> Core[Core Managed Switch]

    Core --> VLAN10[VLAN 10 Management]
    Core --> VLAN20[VLAN 20 Server]
    Core --> VLAN30[VLAN 30 Office Clients]
    Core --> VLAN40[VLAN 40 Production / IoT]
    Core --> VLAN50[VLAN 50 Guest WiFi]
    Core --> VLAN60[VLAN 60 Backup]
    Core --> VLAN70[VLAN 70 Monitoring]

    VLAN10 --> AdminPC[Admin Workstation]
    VLAN10 --> NetBox[NetBox / IPAM / Asset Inventory]

    VLAN20 --> AD[Windows Server / AD DS]
    VLAN20 --> Linux[Linux Server]
    VLAN20 --> Files[File Server]
    VLAN20 --> Docker[Docker Host]

    VLAN30 --> Clients[Windows Clients]
    VLAN30 --> Printers[Network Printers]

    VLAN40 --> PLC[Industrial / IoT Devices]
    VLAN40 --> NAS[Production NAS]

    VLAN50 --> Guest[Guest Devices]

    VLAN60 --> Backup[Backup Server]
    VLAN60 --> Immutable[Immutable Backup Repository]
    Backup --> Offsite[Offsite / Offline Backup]

    VLAN70 --> Zabbix[Zabbix Monitoring]
    VLAN70 --> SIEM[Log Server / SIEM]
    VLAN70 --> Reports[Technical Reports]

    Entra --> MFA[MFA / Conditional Access]
    Mail --> Clients
    AD --> Entra
    Zabbix --> Reports
    SIEM --> Reports
    NetBox --> Reports
EOF
