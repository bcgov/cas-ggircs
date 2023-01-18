-- Verify ggircs-app:tables/ggircs_user on pg

begin;

select pg_catalog.has_table_privilege('ggircs_app.ggircs_user', 'select');

rollback;
