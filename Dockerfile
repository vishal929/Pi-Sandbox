FROM node:trixie-slim

# Install system dependencies, git, and python utilities often required by Pi agents
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    curl \
    jq \
    python3 \
    python3-pip \
    sudo \
    && rm -rf /var/lib/apt/lists/*

# Install the Pi coding agent globally from npm (or adjust to your specific harness package)
RUN npm install -g @earendil-works/pi-coding-agent

# Add the node user to the sudo group and allow passwordless sudo
RUN usermod -aG sudo node \
    && echo "node ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/node 

USER node
WORKDIR /home/node

ENV HOME=/home/node
CMD ["pi"]