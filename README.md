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

## Image variants

All variants create the same non-superuser `dbo` role with the default password
`mysecretpassword`. Change this with the standard `POSTGRES_PASSWORD`
environment variable when starting the container.

| Variant   | Includes                                                                 |
|-----------|--------------------------------------------------------------------------|
| `latest`  | Baseline PostgreSQL image with the `dbo` role configured.                 |
| `dbo`     | Identical to `latest`; published separately for clarity and pinning.      |
| `pgtap`   | Pre-installed [pgTAP](https://pgtap.org/) extension in the `pgtap` schema.|
| `pgcrypto`| Pre-installed `pgcrypto` extension in the `pgcrypto` schema.              |

All images revoke default access from the `public` schema and grant
`dbo` the ability to connect to the default `postgres` database. The `pgtap`
and `pgcrypto` variants temporarily elevate `dbo` during initialization to
install their respective extensions before dropping superuser privileges again.

## Supported PostgreSQL versions

Each variant is published for PostgreSQL major versions 13 through 18. Tags
follow the pattern `<variant>-pg<version>`.

| Variant  | Default tag | Additional tags |
|----------|-------------|-----------------|
| latest   | `latest` → PostgreSQL 18 | `latest-pg13`, `latest-pg14`, `latest-pg15`, `latest-pg16`, `latest-pg17`, `latest-pg18` |
| dbo      | `dbo` → PostgreSQL 18 | `dbo-pg13`, `dbo-pg14`, `dbo-pg15`, `dbo-pg16`, `dbo-pg17`, `dbo-pg18` |
| pgtap    | `pgtap` → PostgreSQL 18 | `pgtap-pg13`, `pgtap-pg14`, `pgtap-pg15`, `pgtap-pg16`, `pgtap-pg17`, `pgtap-pg18` |
| pgcrypto | `pgcrypto` → PostgreSQL 18 | `pgcrypto-pg13`, `pgcrypto-pg14`, `pgcrypto-pg15`, `pgcrypto-pg16`, `pgcrypto-pg17`, `pgcrypto-pg18` |

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
  standard `CREATE EXTENSION` commands—`pgcrypto` and `pgtap` are already
  installed in their dedicated schemas when using those variants.

## Copyright and License

* [MIT License](./LICENSE)
* [Copyright pgTAP](./copyright-pgtap.md)
