# CLAUDE.md

## Project Identity

This repository is an AI-assisted IT Infrastructure Platform focused on:

* IT infrastructure documentation
* Linux administration workflows
* network analysis
* security baseline assessments
* backup documentation
* infrastructure reporting
* NIS2-oriented technical readiness
* customer-facing technical analysis

Target users:

* German KMU
* freelance IT consultants
* system administrators
* infrastructure engineers

---

# Core Engineering Philosophy

Always use the engineering philosophy from:

https://github.com/Protector080322/andrej-karpathy-skills

Core principles:

## 1. Think Before Coding

* Do not assume requirements silently.
* State assumptions explicitly.
* Ask when something is unclear.
* Prefer clarification over hallucination.
* Present tradeoffs when multiple solutions exist.
* Prefer simpler solutions whenever possible.

Before implementing:

* explain the plan briefly
* identify risks
* define verification steps

---

## 2. Simplicity First

* Use the minimum code necessary.
* Avoid speculative abstractions.
* Avoid unnecessary configurability.
* Avoid overengineering.
* Prefer small understandable scripts and workflows.
* If something can be solved in 50 lines instead of 200, simplify it.

The repository must remain maintainable for a single freelance infrastructure engineer.

---

## 3. Surgical Changes

* Modify only what is necessary.
* Do not refactor unrelated code.
* Do not change formatting unnecessarily.
* Match the existing repository style.
* Remove only code made obsolete by your own changes.
* Keep diffs focused and reviewable.

Every modified line must directly support the task.

---

## 4. Goal-Driven Execution

Transform vague requests into verifiable goals.

Examples:

* "Fix bug" → reproduce bug, verify fix.
* "Add validation" → create validation test and verify.
* "Improve workflow" → define measurable workflow outcome.

For multi-step tasks:

1. Define plan
2. Implement incrementally
3. Verify results
4. Summarize outcome

Never claim success without verification.

---

# Infrastructure Engineering Rules

## Preferred Stack

* Bash
* Python
* Docker
* Markdown
* JSON reporting

## Supported Environment

* Linux Mint
* Ubuntu 24.04
* Docker-based tooling

---

# Security Rules

* No destructive commands unless explicitly requested.
* No secrets collection.
* No browser credential extraction.
* No persistence mechanisms.
* No privilege escalation attempts.
* No malware-like behavior.
* No fake compliance guarantees.

This project supports:

* technical documentation
* infrastructure analysis
* operational readiness

This project does NOT provide:

* legal advice
* official audits
* certifications
* guaranteed compliance

---

# Documentation Rules

* Every script must have documentation.
* Every workflow must include verification steps.
* Every example must be realistic.
* Use professional engineering wording.
* Use German wording for customer-facing documentation.
* Use English for technical structures and file naming.

---

# Repository Workflow

Preferred workflow:

1. Analyze current repository state
2. Define small implementation task
3. Implement minimal required changes
4. Verify functionality
5. Update documentation
6. Create clean commit
7. Review diff before merge

Avoid large uncontrolled repository rewrites.

---

# Long-Term Vision

Build a professional open-source AI-assisted infrastructure engineering platform suitable for:

* technical infrastructure assessments
* documentation workflows
* Linux administration
* security baseline analysis
* backup and resilience documentation
* NIS2-oriented technical readiness support

The repository should evolve incrementally through small verifiable engineering steps.
