# Infrastructure Security Toolbox

This Dockerfile provides a standardized environment for running infrastructure assessments, network scans, and security analysis.

## Features
- Network tools: `nmap`, `iputils-ping`, `net-tools`, `curl`, `dig`
- Security tools: `fail2ban`, `ufw`
- Utilities: `vim`, `git`, `bash-completion`

## Build & Run
```bash
docker build -t infra-toolbox .
docker run -it --rm --network host infra-toolbox
```
