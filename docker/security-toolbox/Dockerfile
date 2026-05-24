FROM ubuntu:22.04

LABEL maintainer="Infrastructure Architect"
LABEL version="1.0"
LABEL description="Toolkit for infrastructure auditing and security analysis"

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    curl \
    wget \
    nmap \
    iputils-ping \
    net-tools \
    dnsutils \
    vim \
    git \
    bash-completion \
    python3 \
    python3-pip \
    jq \
    ufw \
    fail2ban \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /toolkit

# Copy local scripts into the container
COPY ./scripts /toolkit/scripts

RUN chmod +x /toolkit/scripts/linux/kmu-infra-audit.sh

ENTRYPOINT ["/bin/bash"]
