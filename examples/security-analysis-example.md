# Example: Production Server Security Analysis

## Input Data (System Audit)
- **Hostname:** web-prod-01
- **OS:** Ubuntu 22.04 LTS
- **Open Ports:** 22/tcp (SSH), 80/tcp (HTTP), 443/tcp (HTTPS)
- **UFW Status:** Active (allow 22, 80, 443)
- **Docker:** Running 2 containers (nginx-proxy, web-app)

## AI Analysis (using prompts/security-audit.md)

### 1. Compliance Scorecard
- **Access Control:** 7/10 (SSH keys used, but no MFA)
- **Vulnerability Mgmt:** 8/10 (Automated updates active)
- **Network Isolation:** 6/10 (Server is in VLAN 20, but has direct public IP)

### 2. Gap Analysis
- **Missing MFA:** No multi-factor authentication for SSH access.
- **Direct Exposure:** The server is directly exposed to the internet instead of being behind a dedicated WAF/Reverse Proxy in the DMZ.
- **Non-Root Containers:** Containers are running as the root user.

### 3. Remediation Plan
1. **Move to DMZ:** Relocate the server to the DMZ and place it behind a WAF (VLAN-independent isolation).
2. **Implement MFA:** Install `libpam-google-authenticator` for SSH.
3. **Hardening:** Use the [Linux Hardening Workflow](../workflows/linux-administration.md) to restrict access further.
4. **Container Security:** Update Dockerfiles to use a non-root `USER`.
