-- Verify ggircs-app:schema_ggircs_app on pg

begin;

select pg_catalog.has_schema_privilege('ggircs_app', 'usage');

rollback;
