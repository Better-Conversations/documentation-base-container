FROM ubuntu:22.04

# Set noninteractive installation
ENV DEBIAN_FRONTEND=noninteractive

# Copy uv binary
COPY --from=ghcr.io/astral-sh/uv:latest /uv /usr/local/bin/uv

# Install basic dependencies first
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        curl \
        sudo \
        ca-certificates \
        build-essential \
        git \
        rsync \
        openssh-client \
        netcat 

# Install TeX packages with workarounds for tex-common issues
RUN apt-get update && \
    # Pre-configure tex-common to avoid interactive prompts
    echo "tex-common tex-common/singleuser boolean true" | debconf-set-selections && \
    # Install texlive-full and related packages
    apt-get install -y --no-install-recommends \
        texlive-full \
        tex-gyre \
        texlive-fonts-extra \
        texlive-fonts-recommended && \
    # Run mktexlsr to update TeX database
    mktexlsr 

# Install Mermaid, Chromium, and Node.js
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs chromium chromium-driver && \
    npm install -g @mermaid-js/mermaid-cli 

# Make Python installed by uv available globally
ENV PATH="/root/.local/bin:$PATH"
# Tell uv which Python version to use by default
ENV UV_PYTHON=3.11

# Set working directory
WORKDIR /app

# Set a default command
CMD ["/bin/bash"] 
