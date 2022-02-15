-- Deploy ggircs:swrs/public/view/taxed_venting_emission_type to pg
-- requires: swrs/parameters/table/taxed_venting_emission_type

begin;

create or replace view swrs.taxed_venting_emission_type as (
  select * from ggircs_parameters.taxed_venting_emission_type
);

comment on view swrs.taxed_venting_emission_type is 'A view that retrieves the data from the ggircs_parameters.taxed_venting_emission_type table. This view is necessary to maintain relationships defined elsewhere like CIIP and metabase after the table was moved to the ggircs_parameters schema';
comment on column swrs.taxed_venting_emission_type.id is 'Unique ID for the taxed_venting_emission_type table';
comment on column swrs.taxed_venting_emission_type.taxed_emission_type is 'The name of the carbon taxed emission type';

commit;
