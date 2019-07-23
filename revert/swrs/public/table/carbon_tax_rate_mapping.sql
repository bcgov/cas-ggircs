-- Revert ggircs:table_carbon_tax_rate_mapping from pg

begin;

drop table swrs.carbon_tax_rate_mapping;

commit;
