# Network Architecture & Segmentation

This document outlines the network segmentation strategy for the KMU (SME) Enterprise Architecture, designed with security and NIS2 readiness in mind.

## VLAN Segmentation Strategy

To minimize the attack surface and prevent lateral movement, the network is divided into several functional VLANs, each with specific security policies enforced by the Core Switch and Next-Gen Firewall (NGFW).

| VLAN ID | Name | Purpose | Key Assets | Security Level |
|---|---|---|---|---|
| **10** | Management | Administrative access to infrastructure | Admin PCs, NetBox, Switch/FW Management | High (Restricted) |
| **20** | Server | Internal server resources | AD DS, Linux Servers, File Servers, Docker Hosts | High |
| **30** | Office Clients | Employee workstations | Windows Laptops/Desktops, Printers | Medium |
| **40** | Production / IoT | Industrial and IoT devices | PLCs, Industrial NAS, Sensors | Medium (Isolated) |
| **50** | Guest WiFi | Internet access for visitors | Guest mobile devices, BYOD | Low (Isolated) |
| **60** | Backup | Dedicated backup traffic | Backup Server, Immutable Repo | High (Restricted) |
| **70** | Monitoring | Infrastructure observation | Zabbix, SIEM, Log Server | High |

## Zone Concepts

### 1. DMZ (Demilitarized Zone)
The DMZ hosts publicly accessible services. It is separated from the internal network by a Reverse Proxy / WAF.
- **Traffic Flow:** Internet -> WAF -> Web Services.
- **Security:** No direct access from DMZ to Internal VLANs.

### 2. Internal Core
The Core Managed Switch handles inter-VLAN routing, while the NGFW inspects traffic between zones with different security levels.

### 3. Isolation & Micro-segmentation
- **VLAN 40 (Production/IoT):** Should have no outbound internet access unless explicitly required for updates. No access to the Server VLAN 20.
- **VLAN 50 (Guest):** Complete isolation. Only outbound traffic to Port 80/443 (Internet) is allowed. No communication with any other VLAN.
- **VLAN 60 (Backup):** Only the Backup Server is allowed to initiate connections to other VLANs for data collection. Access to the Immutable Repository is strictly restricted.

## Remote Access
Secure remote access is provided via **VPN (Virtual Private Network)** with:
- Multi-Factor Authentication (MFA).
- Certificate-based authentication.
- Access restricted to the Management or Office VLANs based on the user role.

## Connectivity Diagram
Refer to the [Infrastructure Architecture](../docs/architecture.md) for a visual representation of the topology.
