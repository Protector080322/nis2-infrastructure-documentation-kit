# AI-Assisted Infrastructure Engineering Toolkit

A professional-grade framework for modern IT infrastructure architecture, security hardening, and NIS2 compliance.

---

## 🚀 Overview

This toolkit transforms infrastructure management into a structured, AI-assisted engineering process. It provides the methodology, documentation, and automation needed to build and maintain secure, resilient, and compliant environments.

### Key Pillars
- **NIS2-oriented technical readiness:** Built-in frameworks for EU cybersecurity directive compliance.
- **Security by Design:** Hardening workflows and network segmentation strategies.
- **AI-Enhanced:** Reusable prompt library to leverage LLMs for analysis and auditing.
- **Infrastructure as Code (IaC):** Standardized patterns for Docker and Linux automation.

---

## 📂 Repository Structure

| Directory | Purpose |
|---|---|
| [`prompts/`](./prompts/) | Reusable AI prompts for infra analysis and security. |
| [`workflows/`](./workflows/) | Standardized IT administration and compliance procedures. |
| [`templates/`](./templates/) | Professional Markdown templates for assets, risks, and changes. |
| [`security/`](./security/) | Security baselines and hardening principles. |
| [`network/`](./network/) | VLAN architecture and network topology. |
| [`scripts/`](./scripts/) | Infrastructure automation and audit tools. |
| [`examples/`](./examples/) | Real-world deployment and analysis examples. |
| [`docs/`](./docs/) | Engineering standards and detailed documentation guides. |

---

## 🛠️ Getting Started

### 1. Assessment
Run the audit script on your existing Linux hosts to gather data:
```bash
./scripts/linux/kmu-infra-audit.sh
```

### 2. AI Analysis
Copy the audit results and use the [Security Audit Prompt](./prompts/security-audit.md) to identify gaps.

### 3. Implementation
Follow the [NIS2 Compliance Workflow](./workflows/nis2-compliance.md) to implement the required technical measures.

### 4. Documentation
Use the [Templates](./templates/) to build your asset inventory and risk register.

---

## 🛡️ Engineering Standards
All contributions and infrastructure projects must adhere to our [Engineering Standards](./docs/standards/engineering-standards.md).

---

## ⚖️ License
This project is licensed under the MIT License.
