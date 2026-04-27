# Stage 1: Build stage
ARG PG_MAJOR=18
ARG PG_VARIANT=alpine

FROM postgres:${PG_MAJOR}-${PG_VARIANT} AS build

# Detect the LLVM major the bundled PostgreSQL was built against (parsed from
# pg_config --configure) and install matching clang/llvm-dev plus a minimal
# build toolchain. Avoids:
#   - Hard-coded LLVM/clang versions that age out of Alpine repos.
#   - Alpine's postgresql-dev package, whose headers only match the *latest*
#     PG release and would link extensions against the wrong server version.
RUN set -eux; \
    apk add --no-cache git build-base perl; \
    LLVM_PKG="$(/usr/local/bin/pg_config --configure | grep -oE 'llvm[0-9]+' | head -n1)"; \
    if [ -n "$LLVM_PKG" ]; then \
        apk add --no-cache "clang${LLVM_PKG#llvm}" "${LLVM_PKG}-dev"; \
    fi; \
    git clone --depth 1 https://github.com/theory/pgtap.git; \
    cd pgtap; \
    make PG_CONFIG=/usr/local/bin/pg_config; \
    make install PG_CONFIG=/usr/local/bin/pg_config; \
    cd ..; \
    rm -rf pgtap

# Stage 2: Final stage
ARG PG_MAJOR=18
ARG PG_VARIANT=alpine
FROM postgres:${PG_MAJOR}-${PG_VARIANT}

COPY --from=build /usr/local/lib/postgresql /usr/local/lib/postgresql
COPY --from=build /usr/local/share/postgresql/extension /usr/local/share/postgresql/extension

WORKDIR /code

COPY ./initdb.sh /docker-entrypoint-initdb.d/a_initdb.sh

# Set the user to postgres, required to comply with scout "Default non-root User" policy
USER postgres

CMD ["postgres"]
