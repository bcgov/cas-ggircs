-- Deploy ggircs:swrs/public/table/drop-deprecated-tables to pg

begin;

  drop table swrs.naics_mapping;
  drop table swrs.naics_category_type;
  drop table swrs.implied_emission_factor;
  drop table swrs.carbon_tax_rate_mapping;

commit;
