# Template: Infrastructure Risk Register

*Purpose: Technical risk identification and mitigation tracking (NIS2-oriented).*

| Risk ID | Asset / Process | Threat Scenario | Technical Vulnerability | Impact (1-5) | Likelihood (1-5) | Score | Mitigation Strategy | Status |
|---|---|---|---|---|---|---|---|---|
| R-001 | Server VLAN | Ransomware Spread | Lack of Micro-segmentation | 5 | 3 | 15 | Implement inter-VLAN ACLs on Firewall | Planned |
| R-002 | Admin Access | Credential Theft | Missing MFA on SSH | 5 | 2 | 10 | Enforce SSH-Key + MFA (Duo/PrivacyIdea) | In Progress |
| R-003 | Internet Edge | DDoS / Exploit | Publicly exposed DB | 4 | 4 | 16 | Move DB to Server VLAN, use WAF/Proxy | Mitigated |
| R-004 | Backup | Data Corruption | No offline/immutable copy | 5 | 2 | 10 | Implement S3 Object Lock or Air-gap | Planned |

---
**Score Calculation:** Impact x Likelihood (1-25)
- **15-25:** Urgent Remediation
- **8-14:** High Priority
- **1-7:** Monitor / Normal Maintenance
