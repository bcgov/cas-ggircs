-- Deploy ggircs:table_carbon_tax_rate_mapping to pg
-- requires: schema_ggircs_swrs

begin;

create table ggircs_swrs.carbon_tax_rate_mapping (
  id integer generated always as identity primary key,
  rate_start_date date,
  rate_end_date date,
  carbon_tax_rate numeric

);
comment on table  ggircs_swrs.carbon_tax_rate_mapping is 'DEPRECATED The carbon tax rate table that maps date with carbon tax rates';
comment on column ggircs_swrs.carbon_tax_rate_mapping.id is 'The internal primary key for the mapping';
comment on column ggircs_swrs.carbon_tax_rate_mapping.rate_start_date is 'The date that the tax rate begins to apply';
comment on column ggircs_swrs.carbon_tax_rate_mapping.rate_end_date is 'The date that the tax rate stops applying';
comment on column ggircs_swrs.carbon_tax_rate_mapping.carbon_tax_rate is 'The carbon tax rate for the date range';

insert into ggircs_swrs.carbon_tax_rate_mapping(rate_start_date, rate_end_date, carbon_tax_rate) values ('0001-01-01', '2017-03-31', 30);
insert into ggircs_swrs.carbon_tax_rate_mapping(rate_start_date, rate_end_date, carbon_tax_rate) values ('2017-04-01', '2018-03-31', 30);
insert into ggircs_swrs.carbon_tax_rate_mapping(rate_start_date, rate_end_date, carbon_tax_rate) values ('2018-04-01', '2019-03-31', 35);
insert into ggircs_swrs.carbon_tax_rate_mapping(rate_start_date, rate_end_date, carbon_tax_rate) values ('2019-04-01', '2020-03-31', 40);
insert into ggircs_swrs.carbon_tax_rate_mapping(rate_start_date, rate_end_date, carbon_tax_rate) values ('2020-04-01', '2021-03-31', 45);
insert into ggircs_swrs.carbon_tax_rate_mapping(rate_start_date, rate_end_date, carbon_tax_rate) values ('2021-04-01', '9999-03-31', 50);

commit;
