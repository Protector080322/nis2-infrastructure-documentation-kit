FROM ubuntu:24.04

################################################################################
# KMU Infrastructure Audit Toolbox
#
# A secure, reproducible Docker environment for infrastructure analysis.
# Includes audit scripts, JSON processing, and reporting tools.
#
# Build: docker build -t kmu-audit-toolbox:1.0 .
# Run:   docker run -it --rm kmu-audit-toolbox:1.0 /bin/bash
################################################################################

LABEL maintainer="Z.R/CyberCheck - Infrastructure & Automation"
LABEL version="1.0.0"
LABEL description="KMU Infrastructure Audit Toolbox"

# Set non-interactive mode
ENV DEBIAN_FRONTEND=noninteractive
ENV TERM=xterm-256color

# Create non-root user for security
RUN useradd -m -s /bin/bash -u 1000 audit && \
    mkdir -p /home/audit/work && \
    chown -R audit:audit /home/audit

################################################################################
# System Base & Updates
################################################################################

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
    # Core utilities
    curl \
    wget \
    git \
    vim \
    nano \
    less \
    # Shell & scripting
    bash \
    bash-completion \
    jq \
    yq \
    moreutils \
    # Network tools
    net-tools \
    iputils-ping \
    dnsutils \
    curl \
    telnet \
    netcat-traditional \
    # System analysis
    htop \
    dstat \
    iotop \
    # Filesystem tools
    tree \
    ncdu \
    lsof \
    # Security & scanning
    openssl \
    openssh-client \
    # JSON & YAML tools
    jq \
    yq \
    python3 \
    python3-pip \
    # Documentation
    pandoc \
    && apt-get clean && \
    rm -rf /var/lib/apt/lists/*

################################################################################
# Python Dependencies for Analysis
################################################################################

RUN pip3 install --no-cache-dir \
    pyyaml \
    jsonschema \
    requests \
    cryptography \
    && python3 -m pip install --upgrade pip setuptools

################################################################################
# Docker Client (for container inspection)
################################################################################

RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
    gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg]" \
    "https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | \
    tee /etc/apt/sources.list.d/docker.list > /dev/null && \
    apt-get update && \
    apt-get install -y --no-install-recommends docker-ce-cli && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

################################################################################
# Install KMU Audit Scripts
################################################################################

RUN mkdir -p /opt/kmu-audit/scripts && \
    mkdir -p /opt/kmu-audit/templates && \
    mkdir -p /opt/kmu-audit/config

# Copy audit script from repository (if mounted)
COPY --chown=audit:audit scripts/kmu-infra-audit.sh /opt/kmu-audit/scripts/
RUN chmod +x /opt/kmu-audit/scripts/kmu-infra-audit.sh

################################################################################
# Create Working Directory
################################################################################

WORKDIR /home/audit/work

# Copy example files
COPY --chown=audit:audit examples/ /opt/kmu-audit/examples/

################################################################################
# Entrypoint Script
################################################################################

RUN cat > /opt/kmu-audit/entrypoint.sh << 'EOF'
#!/bin/bash

set -e

echo "╔════════════════════════════════════════════════════════════════╗"
echo "║     KMU Infrastructure Audit Toolbox - v1.0.0                  ║"
echo "╚════════════════════════════════════════════════════════════════╝"
echo ""
echo "Available tools:"
echo "  - jq           : JSON processing"
echo "  - yq           : YAML processing"
echo "  - docker       : Container management"
echo "  - python3      : Scripting & analysis"
echo "  - curl/wget    : File downloads"
echo ""
echo "Scripts:"
echo "  /opt/kmu-audit/scripts/kmu-infra-audit.sh   : Infrastructure audit"
echo ""
echo "Documentation:"
echo "  /opt/kmu-audit/examples/                    : Example outputs"
echo ""
echo "Working directory: /home/audit/work"
echo ""

if [ "$#" -eq 0 ]; then
    /bin/bash
else
    exec "$@"
fi
EOF

RUN chmod +x /opt/kmu-audit/entrypoint.sh

ENTRYPOINT ["/opt/kmu-audit/entrypoint.sh"]

################################################################################
# Security Hardening
################################################################################

# Set secure permissions
RUN chmod 755 /opt/kmu-audit && \
    find /opt/kmu-audit -type f -exec chmod 644 {} \; && \
    find /opt/kmu-audit/scripts -type f -name "*.sh" -exec chmod 755 {} \;

# Create non-root user volumes
VOLUME ["/home/audit/work"]

# Run as non-root user
USER audit

################################################################################
# Health Check
################################################################################

HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD jq --version > /dev/null && \
    docker --version > /dev/null && \
    echo "OK" || exit 1

################################################################################
# Build Information
################################################################################

LABEL \
    org.opencontainers.image.created="2026-05-28" \
    org.opencontainers.image.version="1.0.0" \
    org.opencontainers.image.vendor="Z.R/CyberCheck" \
    org.opencontainers.image.licenses="MIT"

CMD ["/bin/bash"]
