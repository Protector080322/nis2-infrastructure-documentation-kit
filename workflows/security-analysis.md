# Workflow: Continuous Security Analysis

## 1. Discovery
- **Scan:** Perform internal network scans to identify active hosts and open ports.
- **Inventory:** Compare scan results with the Asset Inventory.

## 2. Vulnerability Assessment
- **Automated:** Use tools like OpenVAS, Nessus, or cloud-native scanners.
- **Manual:** Review configurations for critical systems (Firewalls, AD, Web Servers).
- **AI-Assisted:** Use the [Security Assessment Prompt](../prompts/security-assessment.md) on configuration snippets.

## 3. Hardening & Remediation
- **Prioritize:** Focus on "Critical" and "High" findings first.
- **Patch:** Deploy security updates.
- **Configure:** Tighten firewall rules and service configurations.

## 4. Monitoring & Detection
- **Logs:** Ensure all critical events are sent to the SIEM.
- **Alerts:** Tune alerting rules to minimize false positives.
- **Review:** Weekly review of security dashboards.
