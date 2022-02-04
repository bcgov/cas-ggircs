-- Verify ggircs:swrs/utility/table/emission_category on pg

begin;

select pg_catalog.has_table_privilege('swrs_utility.emission_category', 'select');

rollback;
