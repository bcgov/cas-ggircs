-- Verify ggircs:swrs/parameters/table/taxed_venting_emission_type on pg

begin;

select pg_catalog.has_table_privilege('ggircs_parameters.taxed_venting_emission_type', 'select');

rollback;
