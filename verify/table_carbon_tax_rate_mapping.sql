-- Verify ggircs:table_carbon_tax_rate_mapping on pg

begin;

select pg_catalog.has_table_privilege('ggircs_swrs.carbon_tax_rate_mapping', 'select');

rollback;
