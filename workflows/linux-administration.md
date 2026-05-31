# Workflow: Linux Server Lifecycle Management

## 1. Provisioning & Initial Setup
- **Baseline OS:** Deploy a minimal installation of the target OS (Ubuntu LTS, Debian, RHEL).
- **Identity:** Set hostname and configure internal DNS/A-records.
- **Access:** Inject SSH public keys; disable password authentication.

## 2. Security Hardening
- **Automated Audit:** Run `scripts/linux/kmu-infra-audit.sh` to get the baseline.
- **Apply Hardening:** Use the [Linux Hardening Prompt](../prompts/linux-infrastructure-assessment.md) to generate and run a hardening script.
- **Network:** Configure UFW/Firewalld to allow only required ports.
- **Updates:** Enable `unattended-upgrades`.

## 3. Service Deployment
- **Containerization:** Prefer Docker/Podman for application services.
- **Networking:** Assign to the appropriate VLAN (e.g., VLAN 20 for Servers).
- **Logging:** Configure remote logging to the SIEM (VLAN 70).

## 4. Maintenance & Patching
- **Monthly:** Review audit logs and performance metrics.
- **Quarterly:** Full system upgrade and reboot.
- **Annual:** Full security reassessment and documentation update.

## 5. Decommissioning
- **Data:** Securely wipe data or archive backups.
- **Cleanup:** Remove DNS records, firewall rules, and Entra ID/AD objects.
