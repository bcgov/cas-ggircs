-- Verify ggircs:swrs/public/table/emission_category on pg

begin;

select pg_catalog.has_table_privilege('swrs.emission_category', 'select');

rollback;
