-- Revert ggircs:swrs/transform/function/load_carbon_tax_rate_mapping from pg

begin;

drop function swrs_transform.load_carbon_tax_rate_mapping;

commit;
