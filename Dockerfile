FROM ubuntu:22.04

# Set noninteractive installation
ENV DEBIAN_FRONTEND=noninteractive

# Copy uv binary
COPY --from=ghcr.io/astral-sh/uv:latest /uv /usr/local/bin/uv

# Install dependencies using apt-get (excluding Python) and install Python with uv
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        curl \
        sudo \
        texlive-base \
        texlive-latex-recommended \
        texlive-latex-extra \
        texlive-fonts-recommended \
        ca-certificates \
        build-essential \
        git rsync openssh-client \
    # Clean up apt cache
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Make Python installed by uv available globally
ENV PATH="/root/.local/bin:$PATH"
# Tell uv which Python version to use by default
ENV UV_PYTHON=3.11

# Set working directory
WORKDIR /app

# Set a default command
CMD ["/bin/bash"] 
