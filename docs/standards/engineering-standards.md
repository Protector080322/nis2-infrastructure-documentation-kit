# Infrastructure Engineering Standards

This document defines the professional engineering standards for all infrastructure projects, documentation, and automation within this toolkit.

## 1. Documentation Standards
- **Format:** All documentation must be in Markdown (`.md`).
- **Structure:** Use clear headings, tables for structured data, and code blocks for technical examples.
- **Language:** Technical English is the standard.
- **Versioning:** All documentation should be version-controlled in Git.

## 2. Security by Design
- **Least Privilege:** Always grant the minimum required access level.
- **Segmentation:** Every asset must belong to a defined VLAN.
- **Encryption:** All data in transit must be encrypted (TLS 1.2+ / SSH v2).
- **Hardening:** Every system must be hardened against a baseline (CIS/DISA) before entering production.

## 3. Automation & Scripts
- **Idempotency:** Scripts must be safe to run multiple times without adverse effects.
- **Error Handling:** All scripts must include basic error checking and logging.
- **Clarity:** Use descriptive variable names and comments.
- **Containerization:** Prefer Docker for service deployments to ensure environment consistency.

## 4. Change Management
- No changes to production without a documented change request (see `templates/change-management.md`).
- All changes must have a verified rollback plan.
- Post-implementation verification is mandatory.

## 5. NIS2 Readiness
- Infrastructure design must map to NIS2 requirements.
- Regular assessments are required using the provided assessment scripts.
- Business continuity must be verified through backup restoration tests.
