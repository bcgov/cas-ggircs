-- Verify ggircs:swrs/history/table/attachments_001.sql on pg

begin;

select md5_hash, file_path, zip_file_name
  from swrs_history.report_attachment
 where false;

rollback;
