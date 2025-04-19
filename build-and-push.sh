#!/bin/bash

docker build --platform linux/amd64 -t ghcr.io/better-conversations/documentation-base-container:latest .
docker push ghcr.io/better-conversations/documentation-base-container:latest
