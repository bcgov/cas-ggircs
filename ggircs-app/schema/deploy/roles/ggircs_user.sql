-- Deploy ggircs-app:roles/ggircs_user to pg
begin;

do
$do$
begin
   if not exists (
      select true
      from   pg_catalog.pg_roles
      where  rolname = 'ggircs_user') then

      create role ggircs_user;
   end if;
end
$do$;

commit;
