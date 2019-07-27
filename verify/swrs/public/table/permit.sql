-- Verify ggircs:table_permit on pg

begin;

select pg_catalog.has_table_privilege('swrs.permit', 'select');

commit;
