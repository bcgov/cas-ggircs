-- Deploy ggircs-app:tables/eccc_file_download_log to pg

begin;

create table ggircs_app.eccc_file_download_log
(
  id integer primary key generated always as identity,
  eccc_zip_file_name varchar(1000),
  eccc_individual_file_path varchar(1000),
  downloaded_by int references ggircs_app.ggircs_user,
  downloaded_at timestamp with time zone not null default now()
);

create index eccc_file_download_log_downloaded_by_idx on ggircs_app.eccc_file_download_log(downloaded_by);

create function ggircs_app_private.eccc_file_download_log_insert()
  returns trigger as $$
declare
  ggircs_user_id int;
begin
  ggircs_user_id := (select id from ggircs_app.ggircs_user as cu where cu.uuid = (select sub from ggircs_app.session()));
  new.downloaded_by = ggircs_user_id;
  new.downloaded_at = now();
  return new;
end;
$$ language plpgsql;

grant execute on function ggircs_app_private.eccc_file_download_log_insert to ggircs_user;

create trigger eccc_file_download_log_set_downloaded_by
  before insert on ggircs_app.eccc_file_download_log
  for each row execute procedure ggircs_app_private.eccc_file_download_log_insert();


-- Grant ggircs_user permissions
do
$grant$
begin
perform ggircs_app_private.grant_permissions('select', 'eccc_file_download_log', 'ggircs_user');
perform ggircs_app_private.grant_permissions('insert', 'eccc_file_download_log', 'ggircs_user');
end
$grant$;

comment on table ggircs_app.eccc_file_download_log is 'An immutable log of which user downloaded which ECCC files using the GGIRCS app';
comment on column ggircs_app.eccc_file_download_log.id is 'An internal, generated unique id for the record';
comment on column ggircs_app.eccc_file_download_log.eccc_zip_file_name is 'The name of the Zip file containing the file that was downloaded';
comment on column ggircs_app.eccc_file_download_log.eccc_individual_file_path is 'The path of the file that was downloaded, within the Zip file';
comment on column ggircs_app.eccc_file_download_log.downloaded_by is 'The id of the user that downloaded the file';
comment on column ggircs_app.eccc_file_download_log.downloaded_at is 'The time at which the download was initiated';

commit;
