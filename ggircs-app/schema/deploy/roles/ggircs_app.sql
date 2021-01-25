-- Deploy ggircs-app:roles/ggircs_app to pg

begin;

do
$$
begin
  if not exists (
    select true
    from   pg_catalog.pg_roles
    where  rolname = 'ggircs_app') then

    create user ggircs_app;
  end if;

  grant ggircs_user, ggircs_guest to ggircs_app;
  execute format('grant create, connect on database %I to ggircs_app', current_database());
end;
$$;

commit;
