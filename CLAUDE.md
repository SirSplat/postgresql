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

- **NEVER write code, edit files, or run side-effecting commands (commit, push, workflow dispatch) until you have outlined a plan and the user has explicitly approved it.** Approval signals are short and unambiguous (`go`, `jdi`, `do it`, a numeric option choice). Until then, stay in planning mode — answer questions, propose, refine. Trivial reads, searches, and clarifying questions are exempt; anything that writes, commits, or pushes is not.

- **ALWAYS verify current state before planning or writing changes.** Concretely: (a) check Docker Hub tags at `https://hub.docker.com/r/sirsplat/postgresql/tags`, (b) check CI run history with `gh run list`, (c) read the actual current `Dockerfile` / `initdb.sh` to see today's behaviour rather than what you assume it is, (d) for any new package or binary you plan to depend on, verify it exists in the chosen Alpine version with a one-shot `docker run` probe before encoding it.

- **When asking multiple-choice clarifying questions**, always confirm your understanding of the answer before acting on it — a selected option may not fully capture what the user meant.

- **When auditing documentation against code (or against another doc), enumerate every claim in one and every behaviour in the other in a side-by-side table before drawing any conclusions.** Treat divergence as the default until proven otherwise. Do not rationalise mismatches with "covered elsewhere" arguments without first showing the rationale explicitly.

- **When writing manual user instructions:** (a) define every uncommon term inline on first use, and (b) prefer goal-phrased steps ("grant the gist permission, set to read and write") over UI-step numbers ("click button 5, then radio 3"), since UI layouts rot. If a third-party UI doesn't match what you describe, treat that as a sign your description is stale, not the user's screen.
