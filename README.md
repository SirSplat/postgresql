# PostgreSQL DBO Docker Image

This is a simple container built from PostgreSQL 16-alpine and a dbo role (not a superuser) created.

# **These must not be confused with any official PostgreSQL images provided by PostgreSQL**
I have only used PostgreSQL because it is my RDBMS of choice! That and it's "The World's Most Advanced Open Source Relational Database", go take a gander at [PostgreSQL Documentation](https://www.postgresql.org/) if you do not believe me :)

# Why yet another PostgreSQL Docker image?
Well, because I wanted standardized images that do not use a superuser (postgres by default), for executing application database migrations that I could use for all my other projects.

So use it or don't! In any event, have fun, be safe and ofc "Do not run sh%& as root! :)"

# Feature matrix

|          | latest | dbo | pgtap | pgcrypto|
|----------|:------:|:---:|:-----:|:-------:|
| dbo      | ✔️     | ✔️  |  ||
| pgtap    | ✔️     |     | ✔️ ||
| pgcrypto | ✔️     |     |  | ✔️ |

# How to use this image
```bash
docker run --name some-name -e POSTGRES_PASSWORD=mysecretpassword sirsplat/database -d postgres
```

Now you'll have a running container named some-name, accessable via CMD

```bash
docker exec -it some-name psql -U dbo -h localhost -p 5432 -d postgres
```

# Copyright and License
[MIT License](./LICENSE)

[Copyright pgTAP](./copyright-pgtap.md)
