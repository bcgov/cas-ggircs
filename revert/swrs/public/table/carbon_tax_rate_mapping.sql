-- Revert ggircs:table_carbon_tax_rate_mapping from pg

begin;

drop table ggircs.carbon_tax_rate_mapping;

commit;
