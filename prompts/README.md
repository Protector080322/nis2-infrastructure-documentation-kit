# Prompt Library

This directory contains specialized AI prompts designed to assist in infrastructure analysis, security reviews, and technical readiness assessments.

## Required Categories

| Category | Description | File |
|---|---|---|
| **Security Baseline Review** | Assess foundational security controls. | [security-baseline-review.md](./security-baseline-review.md) |
| **Architecture Review** | Analyze structural resilience and design. | [infrastructure-architecture-review.md](./infrastructure-architecture-review.md) |
| **Linux Assessment** | Detailed system-level evaluation of Linux hosts. | [linux-infrastructure-assessment.md](./linux-infrastructure-assessment.md) |
| **Backup Review** | Evaluate data protection and 3-2-1-1-0 readiness. | [backup-strategy-review.md](./backup-strategy-review.md) |
| **Incident Response** | Review detection and response preparedness. | [incident-response-review.md](./incident-response-review.md) |
| **Docker Security** | Container-specific security hardening analysis. | [docker-security-review.md](./docker-security-review.md) |
| **Network Review** | Analyze segmentation and VLAN architecture. | [network-documentation-review.md](./network-documentation-review.md) |
| **NIS2 Readiness** | High-level assessment of NIS2 technical pillars. | [nis2-oriented-technical-readiness-review.md](./nis2-oriented-technical-readiness-review.md) |

## Usage Guidelines
- Use these prompts with LLMs (e.g., Claude, GPT-4) to process technical data from audit scripts.
- Provide clear context and raw data (JSON or text) for best results.
- **Critical:** Treat all AI output as recommendations. Manual verification by an engineer is always mandatory.
