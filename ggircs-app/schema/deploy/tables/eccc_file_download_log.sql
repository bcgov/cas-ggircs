-- Deploy ggircs-app:tables/eccc_file_download_log to pg

begin;

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

commit;
