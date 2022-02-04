-- Verify ggircs:swrs/utility/table/taxed_venting_emission_type on pg

begin;

select pg_catalog.has_table_privilege('swrs_utility.taxed_venting_emission_type', 'select');

rollback;
