# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Repository for n8n automation platform deployment infrastructure. Builds a custom n8n Docker image with Datadog APM tracing (dd-trace) and deploys it to a VPS via GitHub Actions.

## Architecture

- **Dockerfile.n8n**: Custom n8n image based on `n8nio/n8n:1.123.18`, adds Datadog tracing (`dd-trace`)
- **n8n/data/tracing.js**: Datadog tracer initialization, loaded via `NODE_OPTIONS=-r /tracer/tracing.js`
- **n8n/data/package.json**: Dependencies for the tracer (dd-trace v4+)
- **n8n/entrypoint.sh**: Alternative entrypoint that injects tracing before n8n starts (currently the workflow uses NODE_OPTIONS instead)
- **.github/workflows/n8n-deploy.yml**: CI/CD pipeline — builds Docker image for `linux/arm64`, pushes to GHCR, deploys via SSH to VPS

## Deployment Stack (Production)

All services run with `network_mode: host` on the VPS:
- **n8n** (port 5678) — automation platform with Datadog tracing
- **PostgreSQL 15** (port 5432) — n8n database
- **Redis 7** — caching/queue with password auth, 512MB max memory

Domain: `n8n.ivanildobarauna.dev`

## Build Commands

```bash
# Build the custom n8n image locally (arm64)
docker build -f Dockerfile.n8n -t n8n-custom .
```

## CI/CD

Deployment triggers on push to `main` (ignores `*.md`, `docs/`, `tests/`, `.github/`, `LICENSE`). The workflow:
1. Builds and pushes Docker image to `ghcr.io`
2. Generates a production `docker-compose.prod.yaml` inline
3. Syncs compose + env to VPS via rsync
4. Runs `docker compose up -d` on VPS

Container registry: `ghcr.io/<owner>/ivanildobarauna.dev.automations/n8n`
