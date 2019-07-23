-- Deploy ggircs:ciip_table_facility to pg
-- requires: ciip_table_application
-- requires: ciip_table_operator

begin;

create table ciip_2018.facility
(
    id                                 serial primary key,
    application_id                     integer references ciip_2018.application(id),
    operator_id                        integer references ciip_2018.operator(id),
    swrs_facility_id                   integer,
    facility_name                      varchar(1000),
    facility_type                      varchar(1000),
    bc_ghg_id                          varchar(1000),
    facility_description               varchar(10000),
    production_calculation_explanation varchar(10000),
    production_additional_info         varchar(10000),
    production_public_info             varchar(10000),
    naics                              integer
);

create index ciip_facility_application_foreign_key on ciip_2018.facility(application_id);
create index ciip_facility_operator_foreign_key on ciip_2018.facility(operator_id);

comment on table ciip_2018.facility is 'The table containing information about the facility';
comment on column ciip_2018.facility.id                                 is 'The primary key';
comment on column ciip_2018.facility.application_id                     is 'The application id';
comment on column ciip_2018.facility.operator_id                        is 'The operator id';
comment on column ciip_2018.facility.swrs_facility_id                   is 'The id of the facility in SWRS';
comment on column ciip_2018.facility.facility_name                      is 'The facility name';
comment on column ciip_2018.facility.facility_type                      is 'The facility type (SFO, IF_a, IF_b or L_c)';
comment on column ciip_2018.facility.bc_ghg_id                          is 'The BC GHG Id of the facility';
comment on column ciip_2018.facility.facility_description               is 'The description of the facility';
comment on column ciip_2018.facility.production_calculation_explanation is 'The explanation of how production was calculated for this facility';
comment on column ciip_2018.facility.production_additional_info         is 'The additional info regarding production calculation';
comment on column ciip_2018.facility.production_public_info             is 'The answer to whether production information for the facility is publicly available';
comment on column ciip_2018.facility.naics                              is 'The facility NAICS code';

commit;
