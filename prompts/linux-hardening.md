# Prompt: Linux Server Hardening & Automation

## Role
Act as a Senior Linux Systems Engineer and Security Hardening Expert.

## Context
I need to harden a Linux server (e.g., Ubuntu, Debian, RHEL) according to CIS benchmarks or specific security policies.

## Task
1. Review the provided system information (OS version, running services, open ports).
2. Generate a hardening checklist.
3. Provide a production-ready Bash or Ansible script to automate the hardening process.

## Requirements for the script:
- Must be idempotent.
- Must include logging.
- Must disable root SSH login and enforce key-only auth.
- Must configure a basic firewall (UFW/Firewalld).
- Must remove unnecessary packages.

## Output Format
- **Hardening Summary:** Key areas addressed.
- **Manual Checklist:** Steps that cannot be easily automated.
- **Implementation Script:** The automation code block.
- **Verification Steps:** How to test the hardening.
