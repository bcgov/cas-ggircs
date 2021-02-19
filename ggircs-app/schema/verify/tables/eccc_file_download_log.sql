-- Verify ggircs-app:tables/eccc_file_download_log on pg

begin;

select pg_catalog.has_table_privilege('ggircs_app.eccc_file_download_log', 'select');

rollback;
