---
name: verify-current-state
description: Verify current project state with concrete probes before planning or making changes
type: feedback
originSessionId: b73f03a2-9fcf-4ce2-81a1-038a3f1799f9
---
**Rule:** ALWAYS verify current state before planning or writing changes. Concretely: (a) check Docker Hub tags at https://hub.docker.com/r/sirsplat/postgresql/tags, (b) check CI run history with `gh run list`, (c) read the actual current `Dockerfile` / `initdb.sh` to see today's behaviour rather than what you assume it is, (d) for any new package or binary you plan to depend on, verify it exists in the chosen Alpine version with a one-shot `docker run` probe before encoding it.

**Why:** Repeated pattern of writing changes against assumptions that turned out to be wrong — shipped pgvector with the broken `llvm15-dev clang15` pin without first probing alpine package availability; planned PG 13–18 work in a prior session without checking that the Dockerfiles hardcoded `PG_MAJOR=18`; planned changes that the user later confirmed were already done. Each cost a round of correction or a broken commit.

**How to apply:** Before writing any Dockerfile, workflow yaml, or proposing a CI change, do at least one concrete state probe and report its result in chat before proposing anything that depends on it. Example probes:
- `gh run list --workflow=<name>` — what's CI been doing lately?
- `docker run --rm postgres:13-alpine sh -c 'apk info -e <pkg>'` — does this package exist on this base?
- `docker run --rm <image> sh -c 'ldd /path && pg_config --configure'` — what is the binary actually linked against / configured with?
- `git log -1 -- <path>` — when was this last touched and why?
- `curl -s https://hub.docker.com/v2/repositories/sirsplat/postgresql/tags?page_size=100` — what tags exist on Docker Hub?
