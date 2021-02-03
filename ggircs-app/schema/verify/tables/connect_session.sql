-- Verify ggircs-app:tables/connect-session on pg

begin;

select pg_catalog.has_table_privilege('ggircs_app_private.connect_session', 'select');

rollback;
