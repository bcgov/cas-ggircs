-- Deploy ggircs-app:roles/ggircs_guest to pg
begin;

do
$do$
begin
   if not exists (
      select true
      from   pg_catalog.pg_roles
      where  rolname = 'ggircs_guest') then

      create role ggircs_guest;
   end if;
end
$do$;

commit;
