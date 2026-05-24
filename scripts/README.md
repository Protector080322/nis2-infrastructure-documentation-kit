# Infrastructure Scripts

This directory contains automation scripts for infrastructure analysis, assessmenting, and documentation.

## Available Scripts

### 1. `linux/kmu-infra-assessment.sh`
A basic security and system assessment script for Linux hosts. It collects information about:
- System hardware and OS version.
- Network interfaces and routing.
- Open ports and running services.
- Firewall status and Docker containers.
- Security-relevant system settings.

**Usage:**
```bash
chmod +x linux/kmu-infra-assessment.sh
./linux/kmu-infra-assessment.sh
```
The script generates a text report in the `reports/` directory.

### 2. `generate-enterprise-architecture.sh`
Generates the Mermaid.js source for the KMU Enterprise Architecture diagram.

**Usage:**
```bash
chmod +x generate-enterprise-architecture.sh
./generate-enterprise-architecture.sh
```
This updates the `diagrams/kmu-enterprise-architecture.mmd` file.

## Script Guidelines
- Scripts should be idempotent where possible.
- Ensure all scripts have execution permissions (`chmod +x`).
- Always test scripts in a development or staging environment before running them in production.
- Use `sudo` only when necessary (e.g., for `ufw status` or `docker ps`).

## Contributing
When adding new scripts, please update this README with a description and usage instructions.
