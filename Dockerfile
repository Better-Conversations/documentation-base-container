FROM ubuntu:latest

# Update package lists and install texlive-full
RUN apt-get update && \
    apt-get install -y --no-install-recommends texlive-full texlive-latex-extra && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set a default command (optional)
CMD ["/bin/bash"] 
