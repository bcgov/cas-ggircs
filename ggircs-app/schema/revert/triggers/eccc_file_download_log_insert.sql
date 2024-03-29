-- Revert ggircs-app:triggers/eccc_file_download_log_insert from pg

begin;

-- The original trigger was declared in the eccc_file_download_log table,
-- we need to revert to that implementation

create or replace function ggircs_app_private.eccc_file_download_log_insert()
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

commit;
