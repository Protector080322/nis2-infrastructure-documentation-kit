# Linux Infrastructure Audit Workflow

This workflow provides a safe, read-only method for auditing Linux infrastructure, specifically targeting Ubuntu 24.04 and Linux Mint environments.

## Overview

The audit script (`scripts/linux/kmu-infra-audit.sh`) is designed to collect essential system information without modifying the host or requiring elevated privileges (except where explicitly noted for optional data).

## Security Principles

1.  **Read-Only:** The script only uses non-destructive, informational commands.
2.  **No Credential Collection:** No passwords, keys, or secrets are ever requested or stored.
3.  **No Privilege Escalation:** The script runs as the current user. Some security information (like UFW status) may be limited if run without `sudo`, but the script will handle this gracefully.
4.  **Auditability:** The Bash code is kept simple and modular for easy review by security professionals.

## Requirements

-   Bash 4.0+
-   Standard Linux utilities (`ip`, `ss`, `lscpu`, `free`, `df`, `lsb_release`, `uname`)
-   Docker (optional, for Docker detection)

## Usage

### Human-Readable Report
To generate a text report for immediate review:
```bash
./scripts/linux/kmu-infra-audit.sh
```

### JSON Output
To generate a machine-readable report for automation or documentation:
```bash
./scripts/linux/kmu-infra-audit.sh --json > audit-report.json
```

## Collected Data Points

-   **System:** Hostname, OS version, Kernel version, Uptime, Virtualization type.
-   **Resources:** CPU model and cores, Memory usage, Disk usage (root partition).
-   **Network:** Listening ports, network interface summary.
-   **Docker:** Installation status, Server version, number of running containers.
-   **Security:** Firewall status (UFW), pending package updates.

## Verification

After running the audit, verify the output against the expected infrastructure baseline. An example JSON output is available at `reports/examples/linux-system-report.json`.
