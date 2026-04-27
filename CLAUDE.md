# PostgreSQL DBO Docker Image — Project Guide

## What This Is

A set of Docker images wrapping the official `postgres:<version>-alpine` base image. They add a non-superuser `dbo` role as a safe foundation for running application migrations. Published to Docker Hub as `sirsplat/postgresql`.

## Image Variants

| Variant | Directory | What it adds |
|---------|-----------|--------------|
| `latest` | `latest/` | `dbo` role plus pgTAP, pgcrypto, and pgvector extensions (in their dedicated schemas) |
| `dbo` | `dbo/` | Baseline with `dbo` role only |
| `pgtap` | `pgtap/` | pgTAP testing extension in `pgtap` schema |
| `pgcrypto` | `pgcrypto/` | pgcrypto extension in `pgcrypto` schema |
| `pgvector` | `pgvector/` | pgvector extension (`vector`) in `pgvector` schema |

Each variant has a `Dockerfile` and an `initdb.sh` that runs at container startup.

## PostgreSQL Version Support (13–18)

All Dockerfiles use `ARG PG_MAJOR=18` — the default is 18, but this is overridden at build time by CI. The Dockerfiles themselves are version-agnostic; the version is always injected via `--build-arg PG_MAJOR=<version>`.

CI uses a matrix strategy across versions 13–18, passing `PG_MAJOR` for each. Tags follow the pattern `<variant>-pg<version>` (e.g. `pgtap-pg16`, `dbo-pg13`).

## CI/CD

- Four GitHub Actions workflows (one per variant) in `.github/workflows/`
- Matrix builds for PG 13–18 on every push to `main` and weekly on Sunday
- PRs build but do not push to Docker Hub
- Docker Hub tags are verified after each push using `docker buildx imagetools inspect`

## Rules for Claude

- **ALWAYS suggest verifying current state** (e.g. check Docker Hub tags at `https://hub.docker.com/r/sirsplat/postgresql/tags`, check CI run history) before planning work that might already be done or unnecessary.
- **When asking multiple-choice clarifying questions**, always confirm your understanding of the answer before acting on it — a selected option may not fully capture what the user meant.
