-- Verify ggircs:swrs/parameters/table/naics_category on pg

begin;

select pg_catalog.has_table_privilege('ggircs_parameters.naics_category', 'select');

rollback;
