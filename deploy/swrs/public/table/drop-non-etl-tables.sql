-- Deploy ggircs:swrs/public/table/drop-non-etl-tables to pg

begin;

  drop table swrs.taxed_venting_emission_type;
  drop table swrs.naics_naics_category;
  drop table swrs.naics_mapping;
  drop table swrs.naics_category;
  drop table swrs.naics_category_type;
  drop table swrs.implied_emission_factor;
  drop table swrs.fuel_mapping;
  drop table swrs.fuel_carbon_tax_details;
  drop table swrs.fuel_charge;
  drop table swrs.emission_category;
  drop table swrs.carbon_tax_rate_mapping;
  drop table swrs.carbon_tax_act_fuel_type;

commit;
