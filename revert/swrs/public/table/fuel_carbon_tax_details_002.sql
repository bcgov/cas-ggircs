-- Revert ggircs:swrs/public/table/fuel_carbon_tax_details_002 from pg

begin;

alter table swrs.fuel_carbon_tax_details add column carbon_taxed boolean;

commit;
