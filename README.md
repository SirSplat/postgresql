# PostgreSQL DBO Docker Image

These images build on top of the official `postgres:<version>-alpine` base and
create a reusable `dbo` role that can run application migrations without being a
superuser.  They provide a consistent foundation for local development,
continuous integration, and other automation that should never run as the
cluster owner.

> **Heads-up:** This project is a community-maintained wrapper around the
> upstream PostgreSQL images. It is not affiliated with or endorsed by the
> PostgreSQL Global Development Group. If you are new to PostgreSQL, start with
> the [official documentation](https://www.postgresql.org/docs/)—it's excellent.

## Build status

Per-leg CI status, refreshed automatically after every workflow run. Click any cell to open the workflow's run history on GitHub Actions.

| Variant    | PG 13 | PG 14 | PG 15 | PG 16 | PG 17 | PG 18 |
|------------|-------|-------|-------|-------|-------|-------|
| `latest`   | [![](https://img.shields.io/endpoint?url=https://gist.githubusercontent.com/SirSplat/edb5f33383b2780f4dbe2ff9ac0c8e04/raw/latest-pg13.json)](https://github.com/SirSplat/postgresql/actions/workflows/latest-docker-image.yaml)     | [![](https://img.shields.io/endpoint?url=https://gist.githubusercontent.com/SirSplat/edb5f33383b2780f4dbe2ff9ac0c8e04/raw/latest-pg14.json)](https://github.com/SirSplat/postgresql/actions/workflows/latest-docker-image.yaml)     | [![](https://img.shields.io/endpoint?url=https://gist.githubusercontent.com/SirSplat/edb5f33383b2780f4dbe2ff9ac0c8e04/raw/latest-pg15.json)](https://github.com/SirSplat/postgresql/actions/workflows/latest-docker-image.yaml)     | [![](https://img.shields.io/endpoint?url=https://gist.githubusercontent.com/SirSplat/edb5f33383b2780f4dbe2ff9ac0c8e04/raw/latest-pg16.json)](https://github.com/SirSplat/postgresql/actions/workflows/latest-docker-image.yaml)     | [![](https://img.shields.io/endpoint?url=https://gist.githubusercontent.com/SirSplat/edb5f33383b2780f4dbe2ff9ac0c8e04/raw/latest-pg17.json)](https://github.com/SirSplat/postgresql/actions/workflows/latest-docker-image.yaml)     | [![](https://img.shields.io/endpoint?url=https://gist.githubusercontent.com/SirSplat/edb5f33383b2780f4dbe2ff9ac0c8e04/raw/latest-pg18.json)](https://github.com/SirSplat/postgresql/actions/workflows/latest-docker-image.yaml)     |
| `dbo`      | [![](https://img.shields.io/endpoint?url=https://gist.githubusercontent.com/SirSplat/edb5f33383b2780f4dbe2ff9ac0c8e04/raw/dbo-pg13.json)](https://github.com/SirSplat/postgresql/actions/workflows/dbo-docker-image.yaml)           | [![](https://img.shields.io/endpoint?url=https://gist.githubusercontent.com/SirSplat/edb5f33383b2780f4dbe2ff9ac0c8e04/raw/dbo-pg14.json)](https://github.com/SirSplat/postgresql/actions/workflows/dbo-docker-image.yaml)           | [![](https://img.shields.io/endpoint?url=https://gist.githubusercontent.com/SirSplat/edb5f33383b2780f4dbe2ff9ac0c8e04/raw/dbo-pg15.json)](https://github.com/SirSplat/postgresql/actions/workflows/dbo-docker-image.yaml)           | [![](https://img.shields.io/endpoint?url=https://gist.githubusercontent.com/SirSplat/edb5f33383b2780f4dbe2ff9ac0c8e04/raw/dbo-pg16.json)](https://github.com/SirSplat/postgresql/actions/workflows/dbo-docker-image.yaml)           | [![](https://img.shields.io/endpoint?url=https://gist.githubusercontent.com/SirSplat/edb5f33383b2780f4dbe2ff9ac0c8e04/raw/dbo-pg17.json)](https://github.com/SirSplat/postgresql/actions/workflows/dbo-docker-image.yaml)           | [![](https://img.shields.io/endpoint?url=https://gist.githubusercontent.com/SirSplat/edb5f33383b2780f4dbe2ff9ac0c8e04/raw/dbo-pg18.json)](https://github.com/SirSplat/postgresql/actions/workflows/dbo-docker-image.yaml)           |
| `pgtap`    | [![](https://img.shields.io/endpoint?url=https://gist.githubusercontent.com/SirSplat/edb5f33383b2780f4dbe2ff9ac0c8e04/raw/pgtap-pg13.json)](https://github.com/SirSplat/postgresql/actions/workflows/pgtap-docker-image.yaml)       | [![](https://img.shields.io/endpoint?url=https://gist.githubusercontent.com/SirSplat/edb5f33383b2780f4dbe2ff9ac0c8e04/raw/pgtap-pg14.json)](https://github.com/SirSplat/postgresql/actions/workflows/pgtap-docker-image.yaml)       | [![](https://img.shields.io/endpoint?url=https://gist.githubusercontent.com/SirSplat/edb5f33383b2780f4dbe2ff9ac0c8e04/raw/pgtap-pg15.json)](https://github.com/SirSplat/postgresql/actions/workflows/pgtap-docker-image.yaml)       | [![](https://img.shields.io/endpoint?url=https://gist.githubusercontent.com/SirSplat/edb5f33383b2780f4dbe2ff9ac0c8e04/raw/pgtap-pg16.json)](https://github.com/SirSplat/postgresql/actions/workflows/pgtap-docker-image.yaml)       | [![](https://img.shields.io/endpoint?url=https://gist.githubusercontent.com/SirSplat/edb5f33383b2780f4dbe2ff9ac0c8e04/raw/pgtap-pg17.json)](https://github.com/SirSplat/postgresql/actions/workflows/pgtap-docker-image.yaml)       | [![](https://img.shields.io/endpoint?url=https://gist.githubusercontent.com/SirSplat/edb5f33383b2780f4dbe2ff9ac0c8e04/raw/pgtap-pg18.json)](https://github.com/SirSplat/postgresql/actions/workflows/pgtap-docker-image.yaml)       |
| `pgcrypto` | [![](https://img.shields.io/endpoint?url=https://gist.githubusercontent.com/SirSplat/edb5f33383b2780f4dbe2ff9ac0c8e04/raw/pgcrypto-pg13.json)](https://github.com/SirSplat/postgresql/actions/workflows/pgcrypto-docker-image.yaml) | [![](https://img.shields.io/endpoint?url=https://gist.githubusercontent.com/SirSplat/edb5f33383b2780f4dbe2ff9ac0c8e04/raw/pgcrypto-pg14.json)](https://github.com/SirSplat/postgresql/actions/workflows/pgcrypto-docker-image.yaml) | [![](https://img.shields.io/endpoint?url=https://gist.githubusercontent.com/SirSplat/edb5f33383b2780f4dbe2ff9ac0c8e04/raw/pgcrypto-pg15.json)](https://github.com/SirSplat/postgresql/actions/workflows/pgcrypto-docker-image.yaml) | [![](https://img.shields.io/endpoint?url=https://gist.githubusercontent.com/SirSplat/edb5f33383b2780f4dbe2ff9ac0c8e04/raw/pgcrypto-pg16.json)](https://github.com/SirSplat/postgresql/actions/workflows/pgcrypto-docker-image.yaml) | [![](https://img.shields.io/endpoint?url=https://gist.githubusercontent.com/SirSplat/edb5f33383b2780f4dbe2ff9ac0c8e04/raw/pgcrypto-pg17.json)](https://github.com/SirSplat/postgresql/actions/workflows/pgcrypto-docker-image.yaml) | [![](https://img.shields.io/endpoint?url=https://gist.githubusercontent.com/SirSplat/edb5f33383b2780f4dbe2ff9ac0c8e04/raw/pgcrypto-pg18.json)](https://github.com/SirSplat/postgresql/actions/workflows/pgcrypto-docker-image.yaml) |
| `pgvector` | [![](https://img.shields.io/endpoint?url=https://gist.githubusercontent.com/SirSplat/edb5f33383b2780f4dbe2ff9ac0c8e04/raw/pgvector-pg13.json)](https://github.com/SirSplat/postgresql/actions/workflows/pgvector-docker-image.yaml) | [![](https://img.shields.io/endpoint?url=https://gist.githubusercontent.com/SirSplat/edb5f33383b2780f4dbe2ff9ac0c8e04/raw/pgvector-pg14.json)](https://github.com/SirSplat/postgresql/actions/workflows/pgvector-docker-image.yaml) | [![](https://img.shields.io/endpoint?url=https://gist.githubusercontent.com/SirSplat/edb5f33383b2780f4dbe2ff9ac0c8e04/raw/pgvector-pg15.json)](https://github.com/SirSplat/postgresql/actions/workflows/pgvector-docker-image.yaml) | [![](https://img.shields.io/endpoint?url=https://gist.githubusercontent.com/SirSplat/edb5f33383b2780f4dbe2ff9ac0c8e04/raw/pgvector-pg16.json)](https://github.com/SirSplat/postgresql/actions/workflows/pgvector-docker-image.yaml) | [![](https://img.shields.io/endpoint?url=https://gist.githubusercontent.com/SirSplat/edb5f33383b2780f4dbe2ff9ac0c8e04/raw/pgvector-pg17.json)](https://github.com/SirSplat/postgresql/actions/workflows/pgvector-docker-image.yaml) | [![](https://img.shields.io/endpoint?url=https://gist.githubusercontent.com/SirSplat/edb5f33383b2780f4dbe2ff9ac0c8e04/raw/pgvector-pg18.json)](https://github.com/SirSplat/postgresql/actions/workflows/pgvector-docker-image.yaml) |

## Image variants

All variants create the same non-superuser `dbo` role with the default password
`mysecretpassword`. Change this with the standard `POSTGRES_PASSWORD`
environment variable when starting the container.

| Variant   | Includes                                                                 |
|-----------|--------------------------------------------------------------------------|
| `latest`  | `dbo` role plus the [pgTAP](https://pgtap.org/), `pgcrypto`, and [pgvector](https://github.com/pgvector/pgvector) (as the `vector` extension) extensions, each in their dedicated schemas. |
| `dbo`     | Baseline PostgreSQL image with only the `dbo` role configured.            |
| `pgtap`   | Pre-installed [pgTAP](https://pgtap.org/) extension in the `pgtap` schema.|
| `pgcrypto`| Pre-installed `pgcrypto` extension in the `pgcrypto` schema.              |
| `pgvector`| Pre-installed [pgvector](https://github.com/pgvector/pgvector) extension (`vector`) in the `pgvector` schema. |

All images revoke default access from the `public` schema and grant
`dbo` the ability to connect to the default `postgres` database. The `latest`,
`pgtap`, `pgcrypto`, and `pgvector` variants temporarily elevate `dbo` during
initialization to install their respective extensions before dropping
superuser privileges again.

## Supported PostgreSQL versions

Each variant is published for PostgreSQL major versions 13 through 18. Tags
follow the pattern `<variant>-pg<version>`.

| Variant  | Default tag | Additional tags |
|----------|-------------|-----------------|
| latest   | `latest` → PostgreSQL 18 | `latest-pg13`, `latest-pg14`, `latest-pg15`, `latest-pg16`, `latest-pg17`, `latest-pg18` |
| dbo      | `dbo` → PostgreSQL 18 | `dbo-pg13`, `dbo-pg14`, `dbo-pg15`, `dbo-pg16`, `dbo-pg17`, `dbo-pg18` |
| pgtap    | `pgtap` → PostgreSQL 18 | `pgtap-pg13`, `pgtap-pg14`, `pgtap-pg15`, `pgtap-pg16`, `pgtap-pg17`, `pgtap-pg18` |
| pgcrypto | `pgcrypto` → PostgreSQL 18 | `pgcrypto-pg13`, `pgcrypto-pg14`, `pgcrypto-pg15`, `pgcrypto-pg16`, `pgcrypto-pg17`, `pgcrypto-pg18` |
| pgvector | `pgvector` → PostgreSQL 18 | `pgvector-pg13`, `pgvector-pg14`, `pgvector-pg15`, `pgvector-pg16`, `pgvector-pg17`, `pgvector-pg18` |

Builds on the `main` branch publish these tags to Docker Hub. Pull requests run
full builds for validation but skip the registry login and push steps, so no tags
are published from PR validation jobs.

## Usage

```bash
docker run --name some-name -e POSTGRES_PASSWORD=mysecretpassword sirsplat/postgresql -d postgres
```

This starts a container named `some-name` that exposes PostgreSQL on port 5432.
Connect with the pre-created `dbo` role:

```bash
docker exec -it some-name psql -U dbo -h localhost -p 5432 -d postgres
```

### Customizing the container

* **Use a different password:** set `POSTGRES_PASSWORD` to the desired value.
* **Create a different database:** provide `POSTGRES_DB=my_db`.
* **Persist data:** mount a volume at `/var/lib/postgresql/data` or use Docker
  named volumes so that data outlives the container lifecycle.
* **Enable extensions:** connect as `dbo` (or another privileged role) and run
  standard `CREATE EXTENSION` commands. The `latest` variant includes
  `pgtap`, `pgcrypto`, and `pgvector` (as the `vector` extension) all
  pre-installed in dedicated schemas; the single-extension variants
  (`pgtap`, `pgcrypto`, `pgvector`) install just their named extension.

## Copyright and License

* [MIT License](https://github.com/SirSplat/postgresql/blob/main/LICENSE)
* [Copyright pgTAP](https://github.com/SirSplat/postgresql/blob/main/copyright-pgtap.md)
