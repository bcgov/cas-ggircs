set client_min_messages to warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select plan(3);

select has_table(
  'ggircs_app', 'eccc_file_download_log',
  'ggircs_app.eccc_file_download_log should exist, and be a table'
);

select has_index(
  'ggircs_app',
  'eccc_file_download_log',
  'eccc_file_download_log_downloaded_by_idx',
  'eccc_file_download_log has index: eccc_file_download_log_downloaded_by_idx' );

insert into ggircs_app.ggircs_user(id, uuid, first_name, last_name, email_address)
overriding system value
values (42, '00000000-0000-0000-0000-000000000000', 'Test', 'User', 'ciip@mailinator.com');

set jwt.claims.sub to '00000000-0000-0000-0000-000000000000';

insert into ggircs_app.eccc_file_download_log(id, eccc_zip_file_name, eccc_individual_file_path)
overriding system value
values (123, 'some_file.zip', 'path/to/report.xml');

select is((select downloaded_by from ggircs_app.eccc_file_download_log where id=123), 42, 'The eccc_file_download_log_insert trigger sets the correct user id');

select finish();
rollback;
