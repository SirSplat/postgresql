ARG PG_MAJOR=18
ARG PG_VARIANT=alpine

FROM postgres:${PG_MAJOR}-${PG_VARIANT}

WORKDIR /code

COPY ./initdb.sh /docker-entrypoint-initdb.d/a_initdb.sh

# Set the user to postgres, required to comply with scout "Default non-root User" policy
USER postgres

CMD ["postgres"]
