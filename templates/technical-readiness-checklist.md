# Template: NIS2 Technical Readiness Checklist

*Purpose: Internal assessment of technical controls aligned with the NIS2 directive.*

## 1. Governance & Asset Management
- [ ] **Asset Inventory:** All critical hardware and software documented.
- [ ] **Criticality Mapping:** Business impact of every asset identified.
- [ ] **Risk Assessment:** Annual technical risk review completed.

## 2. Infrastructure Security
- [ ] **Network Segmentation:** VLANs implemented for Management, Server, Clients, IoT, and Backup.
- [ ] **Access Control:** Multi-Factor Authentication (MFA) active for all remote and administrative access.
- [ ] **Hardening:** Documented security baselines applied to all Linux/Windows servers.
- [ ] **Encryption:** TLS 1.2+ for web services and SSH v2 for administration.

## 3. Resilience & Business Continuity
- [ ] **Backup Strategy:** 3-2-1-1-0 rule verified.
- [ ] **Immutability:** At least one copy of backup is immutable or air-gapped.
- [ ] **Restoration Tests:** Quarterly verification of critical system restores.
- [ ] **Disaster Recovery (DR):** Documented plan for site-wide failure.

## 4. Operational Monitoring
- [ ] **Log Management:** Centralized logging for firewall, servers, and critical applications.
- [ ] **Alerting:** Automated notifications for security-relevant events.
- [ ] **Vulnerability Management:** Regular scanning and patching schedule active.

---
*Disclaimer: This checklist is for technical assessment purposes only and does not constitute legal compliance certification.*
