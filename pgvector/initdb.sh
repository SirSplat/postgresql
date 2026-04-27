#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "postgres" --dbname "postgres" <<-ESQL
    CREATE ROLE dbo WITH INHERIT SUPERUSER CREATEDB CREATEROLE LOGIN ENCRYPTED PASSWORD 'mysecretpassword';
    COMMENT ON ROLE dbo IS 'Application database object owner.';
    GRANT pg_read_server_files, pg_read_all_settings TO dbo;

    GRANT CONNECT ON DATABASE postgres TO dbo;
ESQL

psql -v ON_ERROR_STOP=1 --username "dbo" --dbname "template1" <<-ESQL
    CREATE SCHEMA pgvector;
    COMMENT ON SCHEMA pgvector IS 'Home of all things pgvector.';
    CREATE EXTENSION vector WITH SCHEMA pgvector;
ESQL

psql -v ON_ERROR_STOP=1 --username "postgres" --dbname "postgres" <<-ESQL
    ALTER ROLE dbo NOSUPERUSER;
ESQL
