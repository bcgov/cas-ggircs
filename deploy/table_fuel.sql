-- Deploy ggircs:table_fuel to pg
-- requires: schema_ggircs

begin;

create table ggircs.fuel (

    id                                  int generated always as identity primary key,
    ghgr_import_id                      integer,
    activity_name                       varchar(1000),
    sub_activity_name                   varchar(1000),
    unit_name                           varchar(1000),
    sub_unit_name                       varchar(1000),
    fuel_type                           varchar(1000),
    fuel_classification                 varchar(1000),
    fuel_description                    varchar(1000),
    fuel_units                          varchar(1000),
    annual_fuel_amount                  numeric,
    annual_weighted_avg_carbon_content  numeric,
    annual_weighted_avg_hhv             numeric,
    annual_steam_generation             numeric,
    alternative_methodology_description varchar(10000),
    other_flare_details                 varchar(1000),
    q1                                  numeric,
    q2                                  numeric,
    q3                                  numeric,
    q4                                  numeric,
    wastewater_processing_factors       xml,
    measured_conversion_factors         xml
);

comment on table ggircs.fuel is 'The table containing the information on fuels';
comment on column ggircs.fuel.id is 'The primary key';
comment on column ggircs.fuel.ghgr_import_id is 'A foreign key reference to ggircs.ghgr_import';
comment on column ggircs.fuel.activity_name is 'The name of the activity (partial fk reference)';
comment on column ggircs.fuel.sub_activity_name is 'The name of the sub_activity (partial fk reference)';
comment on column ggircs.fuel.unit_name is 'The name of the unit (partial fk reference)';
comment on column ggircs.fuel.sub_unit_name is 'The name of the sub_unit (partial fk reference)';
comment on column ggircs.fuel.fuel_type is 'The type of the fuel';
comment on column ggircs.fuel.fuel_classification is 'The classification of the fuel';
comment on column ggircs.fuel.fuel_description is 'The description of the fuel';
comment on column ggircs.fuel.fuel_units is 'The units of the fuel';
comment on column ggircs.fuel.annual_fuel_amount is 'The annual amount of the fuel';
comment on column ggircs.fuel.annual_weighted_avg_carbon_content is 'The annual weight avg of the fuel carbon content';
comment on column ggircs.fuel.annual_weighted_avg_hhv is 'The annual weight avg of the high heating value of the fuel';
comment on column ggircs.fuel.annual_steam_generation is 'The annual steam generation of the fuel';
comment on column ggircs.fuel.alternative_methodology_description is 'The description of the fuels alternative methodology';
comment on column ggircs.fuel.other_flare_details is 'The other flare details concerning the fuel';
comment on column ggircs.fuel.q1 is 'The fuel used in the first quarter';
comment on column ggircs.fuel.q2 is 'The fuel used in the second quarter';
comment on column ggircs.fuel.q3 is 'The fuel used in the third quarter';
comment on column ggircs.fuel.q4 is 'The fuel used in the fourth quarter';

comment on column ggircs.fuel.wastewater_processing_factors is 'Details on the wastewater processing factors for this fuel';
comment on column ggircs.fuel.measured_conversion_factors is 'Details on the measured_conversion_factors for this fuel';

commit;
