-- Verify ggircs:swrs/public/table/carbon_tax_act_fuel_type on pg

begin;

select pg_catalog.has_table_privilege('swrs.carbon_tax_rate_mapping', 'select');

rollback;
