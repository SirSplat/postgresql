set -e

psql -v ON_ERROR_STOP=1 --username "postgres" --dbname "postgres" <<-ESQL
    CREATE ROLE dbo WITH INHERIT CREATEDB CREATEROLE LOGIN ENCRYPTED PASSWORD 'mysecretpassword';
    COMMENT ON ROLE dbo IS 'Application database object owner.';
    GRANT pg_read_server_files, pg_read_all_settings TO dbo;

    GRANT CONNECT ON DATABASE postgres TO dbo;
    
    REVOKE ALL ON DATABASE postgres FROM public;
    REVOKE ALL ON SCHEMA public FROM public;
ESQL
