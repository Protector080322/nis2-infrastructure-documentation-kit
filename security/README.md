# Security Baseline & NIS2 Readiness

This repository provides a security framework aligned with modern standards and the NIS2 directive for Small and Medium Enterprises (SMEs).

## Security Baseline

A robust security posture starts with fundamental controls across all layers of the infrastructure.

### 1. Identity & Access Management (IAM)
- **Multi-Factor Authentication (MFA):** Enforced for all users, especially for administrative access and remote VPN.
- **Principle of Least Privilege:** Users and services are granted only the minimum permissions required for their tasks.
- **Entra ID / Active Directory:** Centralized identity management with conditional access policies.

### 2. Perimeter Security
- **Next-Gen Firewall (NGFW):** Deep packet inspection, IPS/IDS, and application-aware filtering.
- **WAF / Reverse Proxy:** All public-facing web services must be behind a Web Application Firewall (e.g., Nginx with ModSecurity or Cloudflare).
- **VPN:** Secure, encrypted remote access with MFA.

### 3. Endpoint & Server Hardening
- **Windows Hardening:** Disable unnecessary services, enable BitLocker, enforce password complexity via GPO, and utilize Windows Defender/EDR.
- **Linux Hardening:** SSH key-only authentication, disable root login, utilize `fail2ban`, and regular security patching.
- **Docker Security:** Run containers as non-root, use trusted images, and implement resource limits.

## NIS2 Readiness Framework

The NIS2 directive mandates a high common level of cybersecurity across the EU. Key pillars for readiness include:

| Pillar | Description | Implementation in this Kit |
|---|---|---|
| **Risk Management** | Identifying and mitigating technical risks. | [Technical Audit Scripts](../scripts/README.md) |
| **Incident Handling** | Detecting and responding to security events. | [Monitoring VLAN 70](../network/README.md) |
| **Business Continuity** | Ensuring availability during/after an attack. | [Backup & DR Strategy](../backup/README.md) |
| **Supply Chain Security** | Assessing the security of vendors and partners. | Vendor assessment templates |
| **Vulnerability Disclosure** | Managing and patching known vulnerabilities. | Automated patch management policies |

## Monitoring & Logging

Continuous observation is critical for early threat detection.
- **SIEM / Log Management:** Centralized logging of firewall, server, and application logs.
- **Alerting:** Automated alerts for failed logins, unauthorized access attempts, and system failures.
- **Auditing:** Regular infrastructure audits using the provided scripts in the `scripts/` directory.

## Compliance Documentation
Refer to the `templates/` directory for technical assessment and compliance templates.
