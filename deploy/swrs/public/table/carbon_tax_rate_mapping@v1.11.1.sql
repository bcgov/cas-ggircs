-- Deploy ggircs:table_carbon_tax_rate_mapping to pg
-- requires: schema_ggircs_swrs

begin;

create table swrs.carbon_tax_rate_mapping (
  id integer generated always as identity primary key,
  rate_start_date date,
  rate_end_date date,
  carbon_tax_rate numeric

);
comment on table  swrs.carbon_tax_rate_mapping is 'DEPRECATED The carbon tax rate table that maps date with carbon tax rates';
comment on column swrs.carbon_tax_rate_mapping.id is 'The internal primary key for the mapping';
comment on column swrs.carbon_tax_rate_mapping.rate_start_date is 'The date that the tax rate begins to apply';
comment on column swrs.carbon_tax_rate_mapping.rate_end_date is 'The date that the tax rate stops applying';
comment on column swrs.carbon_tax_rate_mapping.carbon_tax_rate is 'The carbon tax rate for the date range';

commit;
