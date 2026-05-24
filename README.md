# AI-Assisted Infrastructure Engineering Toolkit

A professional-grade framework for modern IT infrastructure architecture, security hardening, and NIS2 readiness.

---

## ⚠️ Disclaimer

*This toolkit is for technical documentation and analysis only. It does not replace legal advice, official audits, or certifications. See [DISCLAIMER.md](./DISCLAIMER.md) for details.*

---

## 🚀 Overview / Überblick

This toolkit transforms infrastructure management into a structured, AI-assisted engineering process. It provides the methodology, documentation, and automation needed to build and maintain secure, resilient, and technical-ready environments.

Dieses Toolkit professionalisiert das Infrastruktur-Management durch strukturierte, KI-gestützte Prozesse. Es liefert die Methodik und Dokumentationsvorlagen für sichere und widerstandsfähige IT-Umgebungen im deutschen Mittelstand (KMU).

### Key Pillars / Kernaspekte
- **NIS2 Readiness:** Frameworks zur Vorbereitung auf die technische Umsetzung der NIS2-Richtlinie.
- **Security by Design:** Hardening workflows and network segmentation strategies.
- **AI-Enhanced:** Reusable prompt library to leverage LLMs for analysis and assessment.
- **Infrastructure as Code (IaC):** Standardized patterns for Docker and Linux automation.

---

## 📂 Repository Structure

| Directory | Purpose |
|---|---|
| [`prompts/`](./prompts/) | Reusable AI prompts for infra analysis and security. |
| [`workflows/`](./workflows/) | Standardized IT administration and readiness procedures. |
| [`templates/`](./templates/) | Professional Markdown templates for assets, risks, and changes. |
| [`security/`](./security/) | Security baselines and hardening principles. |
| [`network/`](./network/) | VLAN architecture and network topology. |
| [`scripts/`](./scripts/) | Infrastructure automation and assessment tools. |
| [`examples/`](./examples/) | Real-world deployment and analysis examples. |
| [`docs/`](./docs/) | Engineering standards and detailed documentation guides. |

---

## 🛠️ Getting Started

### 1. Assessment
Run the assessment script on your existing Linux hosts to gather data:
```bash
./scripts/linux/kmu-infra-assessment.sh
```

### 2. AI Analysis
Copy the assessment results and use the [Security Assessment Prompt](./prompts/security-assessment.md) to identify gaps.

### 3. Implementation
Follow the [NIS2 Readiness Workflow](./workflows/nis2-readiness.md) to implement the required technical measures.

### 4. Documentation
Use the [Templates](./templates/) to build your asset inventory and risk register.

---

## 🇩🇪 Service Description & Portfolio
Für deutsche Interessenten und Kunden:
- [Leistungsbeschreibung (Service Description)](./docs/service-description-de.md)
- [Portfolio-Beschreibung](./docs/portfolio-description-de.md)

---

## 🛡️ Engineering Standards
All contributions and infrastructure projects must adhere to our [Engineering Standards](./docs/standards/engineering-standards.md).

---

## ⚖️ License
This project is licensed under the MIT License.
