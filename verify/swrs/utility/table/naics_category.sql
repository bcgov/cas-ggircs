-- Verify ggircs:swrs/utility/table/naics_category on pg

begin;

select pg_catalog.has_table_privilege('swrs_utility.naics_category', 'select');

rollback;

