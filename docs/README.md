# Documentation Guide

Welcome to the NIS2 Infrastructure Documentation Kit. This guide provides a central overview of all technical documentation and security frameworks included in this repository.

## Documentation Structure

| Section | Focus | Link |
|---|---|---|
| **Network** | Segmentation, VLANs, and Topology | [Network README](../network/README.md) |
| **Security** | Baseline, Hardening, and NIS2 | [Security README](../security/README.md) |
| **Backup** | 3-2-1-1-0 Rule and Disaster Recovery | [Backup README](../backup/README.md) |
| **Templates** | Technical Assessment Templates | [Templates README](../templates/README.md) |
| **Scripts** | Infrastructure Auditing & Automation | [Scripts README](../scripts/README.md) |

## Core Principles

The documentation in this kit is built upon three core principles:

1. **Security by Design:** Every architectural decision is evaluated for its security impact.
2. **NIS2 Readiness:** Frameworks are aligned with the requirements of the NIS2 directive for SMEs.
3. **Operational Clarity:** Documentation should be practical, clear, and actionable for IT administrators.

## Getting Started

1. **Review the [Infrastructure Architecture](./architecture.md):** Understand the high-level design.
2. **Perform an Audit:** Use the [Audit Script](../scripts/README.md#1-linuxkmu-infra-auditsh) to assess your current environment.
3. **Implement Segmentation:** Follow the [VLAN Guide](../network/README.md) to isolate your network zones.
4. **Define Backups:** Establish a robust strategy using the [Backup Framework](../backup/README.md).
5. **Hardening:** Apply security baselines from the [Security Section](../security/README.md).

## Versioning & Maintenance

Technical documentation must be kept up to date. It is recommended to review and update these documents:
- After any significant infrastructure change.
- Following a security incident or audit.
- At least once every six months.
