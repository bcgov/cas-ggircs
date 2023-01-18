-- Deploy ggircs-app:triggers/update_timestamps to pg


begin;

create or replace function ggircs_app_private.update_timestamps()
  returns trigger as $$
declare
  user_sub text;
  ggircs_user_id int;
begin
  user_sub := (select sub from ggircs_app.session());
  ggircs_user_id := (select id from ggircs_app.ggircs_user as gu where gu.session_sub = user_sub);
  if tg_op = 'INSERT' then
    new.created_at = now();
    new.created_by = ggircs_user_id;
    new.updated_at = now();
    new.updated_by = ggircs_user_id;
  elsif tg_op = 'UPDATE' then
    if old.deleted_at is distinct from new.deleted_at then
      new.deleted_at = now();
      new.deleted_by = ggircs_user_id;
    else
      new.created_at = old.created_at;
      new.updated_at = greatest(now(), old.updated_at + interval '1 millisecond');
      new.updated_by = ggircs_user_id;
    end if;
  end if;
  return new;
end;
$$ language plpgsql;

commit;
