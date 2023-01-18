-- Verify ggircs-app:triggers/eccc_file_download_log_insert on pg

begin;

select pg_get_functiondef('ggircs_app_private.eccc_file_download_log_insert()'::regprocedure);

rollback;
