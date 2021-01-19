-- Verify ggircs-app:schema_ggircs_app_private on pg

begin;

select pg_catalog.has_schema_privilege('ggircs_app_private', 'usage');

rollback;
