#!/bin/bash

versions=("13" "14" "15" "16" "17")
variants=("latest" "dbo" "pgtap" "pgcrypto")

for version in "${versions[@]}"; do
  for variant in "${variants[@]}"; do
    dir="./${version}/${variant}"
    mkdir -p "${dir}"

    if [[ "${variant}" == "latest" || "${variant}" == "pgtap" ]]; then
      template="Dockerfile_with_pgtap"
    else
      template="Dockerfile_without_pgtap"
    fi

    # Replace the placeholder with the actual version
    sed "s/ARG PG_VERSION=17/ARG PG_VERSION=${version}/" ${template} > "${dir}/Dockerfile"

    # Generate initdb.sh script
    cat <<EOF > "${dir}/initdb.sh"
#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "postgres" --dbname "postgres" <<-ESQL
    CREATE ROLE dbo WITH INHERIT SUPERUSER CREATEDB CREATEROLE LOGIN ENCRYPTED PASSWORD 'mysecretpassword';
    COMMENT ON ROLE dbo IS 'Application database object owner.';
    GRANT pg_read_server_files, pg_read_all_settings TO dbo;

    GRANT CONNECT ON DATABASE postgres TO dbo;

    REVOKE ALL ON DATABASE postgres FROM public;
    REVOKE ALL ON SCHEMA public FROM public;
ESQL
EOF

    if [[ "${variant}" == "latest" || "${variant}" == "pgtap" ]]; then
      cat <<EOF >> "${dir}/initdb.sh"

psql -v ON_ERROR_STOP=1 --username "dbo" --dbname "template1" <<-ESQL
    CREATE SCHEMA pgtap;
    COMMENT ON SCHEMA pgtap IS 'Home of all things PGTap.';
    CREATE EXTENSION pgtap WITH SCHEMA pgtap;
ESQL
EOF
    fi

    if [[ "${variant}" == "latest" || "${variant}" == "pgcrypto" ]]; then
      cat <<EOF >> "${dir}/initdb.sh"

psql -v ON_ERROR_STOP=1 --username "dbo" --dbname "template1" <<-ESQL
    CREATE SCHEMA pgcrypto;
    COMMENT ON SCHEMA pgcrypto IS 'Home of all things PGCrypto.';
    CREATE EXTENSION pgcrypto WITH SCHEMA pgcrypto;
ESQL
EOF
    fi

    cat <<EOF >> "${dir}/initdb.sh"

psql -v ON_ERROR_STOP=1 --username "postgres" --dbname "postgres" <<-ESQL
    ALTER ROLE dbo NOSUPERUSER;
ESQL
EOF

  done
done