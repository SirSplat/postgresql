# PostgreSQL DBO Docker Image

This is a simple container built from PostgreSQL 18-alpine by default with a dbo role (not a superuser) created.

# **These must not be confused with any official PostgreSQL images provided by PostgreSQL**
I have used PostgreSQL because it is my RDBMS of choice! That and it's "The World's Most Advanced Open Source Relational Database", go take a gander at [PostgreSQL Documentation](https://www.postgresql.org/) if you want to see for yourself. :)

# Why yet another PostgreSQL Docker image?
Well, because I wanted standardized images that do not use a superuser (postgres by default), for executing application database migrations that I could use for all my other projects.

So use it or don't! In any event, have fun, be safe and ofc "Do not run sh%& as root! :)"

# Supported PostgreSQL versions

Each image variant is published for PostgreSQL major versions 13 through 18. Tags follow the pattern `<variant>-pg<version>`.

| Variant  | Default tag | Additional tags |
|----------|-------------|-----------------|
| latest   | `latest` → PostgreSQL 18 | `latest-pg13`, `latest-pg14`, `latest-pg15`, `latest-pg16`, `latest-pg17`, `latest-pg18` |
| dbo      | `dbo` → PostgreSQL 18 | `dbo-pg13`, `dbo-pg14`, `dbo-pg15`, `dbo-pg16`, `dbo-pg17`, `dbo-pg18` |
| pgtap    | `pgtap` → PostgreSQL 18 | `pgtap-pg13`, `pgtap-pg14`, `pgtap-pg15`, `pgtap-pg16`, `pgtap-pg17`, `pgtap-pg18` |
| pgcrypto | `pgcrypto` → PostgreSQL 18 | `pgcrypto-pg13`, `pgcrypto-pg14`, `pgcrypto-pg15`, `pgcrypto-pg16`, `pgcrypto-pg17`, `pgcrypto-pg18` |

Scheduled, manual, and branch builds on `main` publish these tags to Docker Hub. Pull request runs build the images for validation but skip the registry login and push steps by design, so no tags are published from PR validation jobs.

# How to use this image
```bash
docker run --name some-name -e POSTGRES_PASSWORD=mysecretpassword sirsplat/postgresql -d postgres
```

Now you'll have a running container named some-name, accessable via CMD

```bash
docker exec -it some-name psql -U dbo -h localhost -p 5432 -d postgres
```

# Copyright and License
[MIT License](./LICENSE)

[Copyright pgTAP](./copyright-pgtap.md)
