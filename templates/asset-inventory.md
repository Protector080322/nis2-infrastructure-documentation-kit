# Template: Infrastructure Asset Inventory

*Purpose: Comprehensive tracking of hardware, virtual, and critical software assets for German KMU environments.*

| Asset ID | Hostname | IP Address | OS / Version | Role / Function | VLAN | Criticality | Owner (Dept) | Last Audit |
|---|---|---|---|---|---|---|---|---|
| SRV-001 | srv-prod-db | 10.20.0.10 | Ubuntu 24.04 | Main Production DB | 20 (Server) | Critical | IT / Ops | 2024-05-15 |
| NET-001 | core-sw-01 | 10.10.0.1 | JunOS 21.x | Core L3 Switch | 10 (Mgmt) | Critical | IT / Admin | 2024-04-10 |
| BK-001 | backup-repo | 10.60.0.5 | Debian 12 | Immutable Backup Repo | 60 (Backup) | High | IT / Backup | 2024-05-01 |
| APP-001 | erp-web-01 | 10.20.0.20 | Docker / Alpine | Web Frontend ERP | 20 (Server) | High | Finance | 2024-05-10 |

---
### Asset Categorization (KMU Standard)
- **Critical:** Immediate business stop if failed (ERP, Core Network, Primary DB).
- **High:** Significant disruption, but temporary workarounds possible (File Server, Mail).
- **Medium:** Operational impact, limited scope (Printers, non-critical Apps).
- **Low:** Minimal impact (Test systems, Guest WiFi).

*Last updated: 202X-XX-XX*
