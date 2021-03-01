-- Revert ggircs-app:tables/eccc_file_downloads from pg

begin;

drop table ggircs_app.eccc_file_download_log;
drop function ggircs_app_private.eccc_file_download_log_insert;

commit;
