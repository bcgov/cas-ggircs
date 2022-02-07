-- Deploy ggircs:swrs/transform/function/load_carbon_tax_rate_mapping to pg
-- requires: swrs/transform/schema
-- requires: swrs/public/table/carbon_tax_rate_mapping

begin;

drop function swrs_transform.load_carbon_tax_rate_mapping;

commit;
