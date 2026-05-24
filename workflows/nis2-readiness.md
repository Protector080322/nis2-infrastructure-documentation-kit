# Workflow: NIS2 Readiness Implementation

## Phase 1: Preparation & Scoping
1. **Identify Essential/Important Entities:** Determine if the organization falls under NIS2 scope.
2. **Asset Inventory:** Populate the `templates/asset-inventory.md`.
3. **Risk Analysis:** Conduct a high-level risk assessment using `templates/risk-assessment.md`.

## Phase 2: Technical Implementation
1. **Network Segmentation:** Implement the [VLAN Strategy](../network/README.md).
2. **Access Control:** Enforce MFA for all administrative and remote access.
3. **Security Hardening:** Apply baselines to all endpoints and servers.
4. **Resilience:** Configure the [3-2-1-1-0 Backup Strategy](../backup/README.md).

## Phase 3: Organizational Implementation
1. **Incident Response:** Define and test the incident response plan.
2. **Supply Chain:** Review security requirements for key vendors.
3. **Training:** Conduct cybersecurity awareness training for employees.

## Phase 4: Verification & Assessment
1. **Internal Assessment:** Use provided [Security Assessment Prompts](../prompts/security-assessment.md).
2. **Remediation:** Address identified gaps.
3. **External Review:** (If applicable) Prepare for technical review.
