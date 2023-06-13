-- Verify ggircs:swrs/parameters/table/gwp on pg

begin;

select pg_catalog.has_table_privilege('ggircs_parameters.gwp', 'select');

rollback;
