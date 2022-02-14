-- Verify ggircs:swrs/parameters/table/emission_category on pg

begin;

select pg_catalog.has_table_privilege('ggircs_parameters.emission_category', 'select');

rollback;
