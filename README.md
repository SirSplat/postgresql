# Introduction

This is a simple container built from PostgreSQL 16-alpine, a dbo role (not a superuser) and installed pgTAP 1.3.4

# Why yet another PostgreSQL and pgTAP Docker image?
Well, because I wanted a standardized image that doesn't use a superuser (postgres by default), for executing application database migrations that I could use for all my projects.

So use it or don't! In any event, have fun, be safe and ofc "Do not run sh%& as root! :)"

# How to use this image
## Start an instance
```
docker run --name some-name -e POSTGRES_PASSWORD=mysecretpassword -d postgres
```
Now you'll have a running container named some-name, accessable via CMD
```
docker exec -it some-name psql -U dbo -p 5432 -d postgres -h localhost
```

## From a Dockerfile
```
FROM sirsplat/postgresql-pgtap:latest

# Set the working directory
WORKDIR /code

# Copy initialization script
COPY ./initdb.sh ./initdb.sh

# Set the user to postgres, required to comply with scout "Default non-root User" policy
USER postgres

# Set the command to run PostgreSQL
CMD ["postgres"]
```
Then execute your initdb.sh
```
docker exec -it some-name psql -U dbo -p 5432 -d postgres -h localhost -f /code/initdb.sh
```

## From docker-compose
```
Well I don't know just quite yet. Still working on mine. So will update here when I got mine functioning
```

# License
This uses the [MIT License](LICENSE).

[pgTAP](https://pgtap.org/)[ License⁠](PGTAP-LICENSE.md)
