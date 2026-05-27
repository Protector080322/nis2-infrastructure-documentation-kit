# TASKS.md

## Engineering Philosophy

All implementation tasks must follow:

https://github.com/Protector080322/andrej-karpathy-skills

Core rules:
- Think Before Coding
- Simplicity First
- Surgical Changes
- Goal-Driven Execution

---

# Current Roadmap

## Phase 1 — Foundation

### Task 01
Create safe Linux infrastructure audit scripts.

Goals:
- system information
- network interfaces
- open ports
- Docker detection
- firewall status
- update status

Verification:
- scripts execute without destructive behavior
- outputs are readable
- JSON output examples exist

---

### Task 02
Create JSON reporting structure.

Goals:
- infrastructure inventory output
- security baseline output
- audit summary reports

Verification:
- valid JSON structure
- realistic examples

---

### Task 03
Create Docker-based security toolbox.

Goals:
- reproducible environment
- safe tooling
- documented usage

Verification:
- container builds successfully
- documentation is complete

---

## Phase 2 — Reporting

### Task 04
Management-ready Markdown reports.

### Task 05
Infrastructure assessment templates.

### Task 06
Backup verification workflow.

---

## Phase 3 — Automation

### Task 07
GitHub Actions CI.

### Task 08
Infrastructure diagram generation.

### Task 09
Render deployment planning.

---

# Safety Rules

Never:
- collect secrets
- store credentials
- execute destructive commands
- perform persistence mechanisms
- create malware-like functionality

Always:
- prefer read-only analysis
- verify outputs
- document scripts
- keep diffs reviewable
