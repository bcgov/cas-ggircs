-- Deploy ggircs:swrs/parameters/table/taxed_venting_emission_type to pg
-- requires: swrs/parameters/schema

begin;

create table ggircs_parameters.taxed_venting_emission_type (
  id integer primary key generated always as identity,
  taxed_emission_type varchar(1000)
);

comment on table ggircs_parameters.taxed_venting_emission_type is 'Table of emission types that are carbon taxed in relation to venting as per https://www.bclaws.gov.bc.ca/civix/document/id/complete/statreg/249_2015#ScheduleA';
comment on column ggircs_parameters.taxed_venting_emission_type.id is 'Unique ID for the taxed_venting_emission_type table';
comment on column ggircs_parameters.taxed_venting_emission_type.taxed_emission_type is 'The name of the carbon taxed emission type';

insert into ggircs_parameters.taxed_venting_emission_type(
  taxed_emission_type
)
values
  ('NG Distribution: NG continuous high bleed devices venting'),
  ('NG Distribution: NG continuous low bleed devices venting'),
  ('NG Distribution: NG intermittent devices venting'),
  ('NG Distribution: NG pneumatic pumps venting'),
  ('Onshore NG Transmission Compression/Pipelines: NG continuous high bleed devices venting'),
  ('Onshore NG Transmission Compression/Pipelines: NG continuous low bleed devices venting'),
  ('Onshore NG Transmission Compression/Pipelines: NG intermittent devices venting'),
  ('Onshore NG Transmission Compression/Pipelines: NG pneumatic pumps venting'),
  ('Onshore Petroleum and NG Production: NG continuous high bleed devices venting'),
  ('Onshore Petroleum and NG Production: NG continuous low bleed devices venting'),
  ('Onshore Petroleum and NG Production: NG intermittent devices venting'),
  ('Onshore Petroleum and NG Production: NG pneumatic pump venting'),
  ('Underground NG Storage: NG continuous high bleed devices venting'),
  ('Underground NG Storage: NG continuous low bleed devices venting'),
  ('Underground NG Storage: NG intermittent devices venting'),
  ('Underground NG Storage: NG pneumatic pumps venting');

commit;
