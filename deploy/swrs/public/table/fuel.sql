-- Deploy ggircs:table_fuel to pg
-- requires: schema_ggircs

begin;

create table swrs.fuel (

    id                                  integer primary key,
    ghgr_import_id                      integer,
    report_id                           integer references swrs.report(id),
    unit_id                             integer references swrs.unit(id),
    fuel_mapping_id                     integer references swrs.fuel_mapping(id),
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
    q4                                  numeric
);

create index ggircs_fuel_report_foreign_key on swrs.fuel(report_id);
create index ggircs_fuel_unit_foreign_key on swrs.fuel(unit_id);
create index ggircs_fuel_fuel_mapping_foreign_key on swrs.fuel(fuel_mapping_id);

comment on table swrs.fuel is 'The table containing the information on fuels';
comment on column swrs.fuel.id is 'The primary key';
comment on column swrs.fuel.ghgr_import_id is 'A foreign key reference to swrs.ghgr_import';
comment on column swrs.fuel.report_id is 'A foreign key reference to swrs.report';
comment on column swrs.fuel.unit_id is 'A foreign key reference to swrs.unit';
comment on column swrs.fuel.fuel_mapping_id is 'A foreign key reference to swrs.fuel_mapping';
comment on column swrs.fuel.activity_name is 'The name of the activity (partial fk reference)';
comment on column swrs.fuel.sub_activity_name is 'The name of the sub_activity (partial fk reference)';
comment on column swrs.fuel.unit_name is 'The name of the unit (partial fk reference)';
comment on column swrs.fuel.sub_unit_name is 'The name of the sub_unit (partial fk reference)';
comment on column swrs.fuel.fuel_type is 'The type of the fuel';
comment on column swrs.fuel.fuel_classification is 'The classification of the fuel';
comment on column swrs.fuel.fuel_description is 'The description of the fuel';
comment on column swrs.fuel.fuel_units is 'The units of the fuel';
comment on column swrs.fuel.annual_fuel_amount is 'The annual amount of the fuel';
comment on column swrs.fuel.annual_weighted_avg_carbon_content is 'The annual weight avg of the fuel carbon content';
comment on column swrs.fuel.annual_weighted_avg_hhv is 'The annual weight avg of the high heating value of the fuel';
comment on column swrs.fuel.annual_steam_generation is 'The annual steam generation of the fuel';
comment on column swrs.fuel.alternative_methodology_description is 'The description of the fuels alternative methodology';
comment on column swrs.fuel.other_flare_details is 'The other flare details concerning the fuel';
comment on column swrs.fuel.q1 is 'The fuel used in the first quarter';
comment on column swrs.fuel.q2 is 'The fuel used in the second quarter';
comment on column swrs.fuel.q3 is 'The fuel used in the third quarter';
comment on column swrs.fuel.q4 is 'The fuel used in the fourth quarter';

commit;
