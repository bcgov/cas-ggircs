-- Deploy ggircs:swrs/public/table/fuel_carbon_tax_details_002 to pg
-- requires: swrs/public/table/fuel_carbon_tax_details_001

begin;

alter table swrs.fuel_carbon_tax_details drop column carbon_taxed;

commit;
