-- Deploy ggircs-app:triggers/user_session_sub_immutable_with_flag to pg

begin;

create or replace function ggircs_app_private.user_session_sub_immutable_with_flag_set()
returns trigger as $$
begin
  if not old.allow_sub_update then
    raise exception 'session_sub cannot be updated when allow_sub_update is false';
  end if;
  return new;
end;
$$ language plpgsql;

grant execute on function ggircs_app_private.user_session_sub_immutable_with_flag_set to ggircs_user;

comment on function ggircs_app_private.user_session_sub_immutable_with_flag_set()
  is $$
    A trigger that raises an exception if the session_sub of a user is being updated with the allow_sub_update flag set to false
  $$;

commit;
