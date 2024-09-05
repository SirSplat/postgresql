# Stage 1: Build stage
ARG PG_VERSION=16.3-alpine

FROM postgres:${PG_VERSION} AS build

# Install required packages and build tools
RUN apk add --no-cache --update \
    postgresql-dev postgresql-contrib git openssl build-base make perl perl-dev less wget \
    llvm15-dev clang15 \
    && rm -rf /var/cache/apk/* /tmp/* \
    && cpan TAP::Parser::SourceHandler::pgTAP \
    && cpan Template \
    && git clone https://github.com/theory/pgtap.git \
    && cd pgtap \
    && make \
    && make install \
    && cd .. \
    && rm -rf pgtap

# Stage 2: Final stage
FROM postgres:${PG_VERSION}

# Copy installed extensions from the build stage
COPY --from=build /usr/local/lib/postgresql /usr/local/lib/postgresql
COPY --from=build /usr/local/share/postgresql/extension /usr/local/share/postgresql/extension

# Set the working directory
WORKDIR /code

# Copy initialization script (if any)
COPY ./initdb.sh /docker-entrypoint-initdb.d/a_initdb.sh

# Set the user to postgres, required to comply with scout "Default non-root User" policy
USER postgres

# Set the command to run PostgreSQL
CMD ["postgres"]