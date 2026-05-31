# Template: Backup Restoration Verification Log

*Purpose: Regular evidence of functional data protection and recovery capability.*

| Date | System / Asset | Restore Type | Source | Result | Time Taken | Verified By |
|---|---|---|---|---|---|---|
| 2024-05-01 | SRV-PROD-DB | Full VM | Local Repo | Success | 45m | Admin |
| 2024-05-02 | FILE-SERVER | File-Level | Offsite (S3) | Success | 15m | Ops |
| 2024-05-15 | ERP-DATA | Database | Immutable | Success | 30m | DB-Admin |

---

## Detailed Test Report: [System Name] - [Date]
- **Scenario:** (e.g., Deleted folder, Ransomware simulation, Disk failure)
- **Recovery Point Objective (RPO) checked:** (Last backup was X hours old)
- **Recovery Time Objective (RTO) achieved:** (Restoration took Y minutes)
- **Integrity Check:** (e.g., md5sum match, application login successful)
- **Notes/Issues:**
