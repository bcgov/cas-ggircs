-- Deploy ggircs-app:tables/eccc_file_download_log to pg

begin;

-- Replacing the function is not enough, we need to drop and recreate the trigger
drop trigger eccc_file_download_log_set_downloaded_by on ggircs_app.eccc_file_download_log;

create or replace function ggircs_app_private.eccc_file_download_log_insert()
  returns trigger as $$
declare
  ggircs_user_id int;
begin
  ggircs_user_id := (select id from ggircs_app.ggircs_user as gu where gu.session_sub = (select sub from ggircs_app.session()));
  new.downloaded_by = ggircs_user_id;
  new.downloaded_at = now();
  return new;
end;
$$ language plpgsql;

grant execute on function ggircs_app_private.eccc_file_download_log_insert to ggircs_user;

create trigger eccc_file_download_log_set_downloaded_by
  before insert on ggircs_app.eccc_file_download_log
  for each row execute procedure ggircs_app_private.eccc_file_download_log_insert();


commit;
