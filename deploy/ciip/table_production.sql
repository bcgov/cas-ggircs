-- Deploy ggircs:ciip_table_production to pg
-- requires: ciip_table_application
begin;

create table ciip.production
(
    id                        serial primary key,
    application_id            integer references ciip.application(id),
    facility_id               integer references ciip.facility(id),
    operator_id               integer references ciip.operator(id),
    product                   varchar(1000),
    quantity                  numeric,
    units                     varchar(1000),
    associated_emissions      numeric
);

create index ciip_production_application_foreign_key on ciip.production(application_id);
create index ciip_production_facility_foreign_key on ciip.production(facility_id);
create index ciip_production_operator_foreign_key on ciip.production(operator_id);

comment on table ciip.production is 'The production amounts of a facility';
comment on column ciip.production.id                   is 'The primary key';
comment on column ciip.production.application_id       is 'The application id';
comment on column ciip.production.facility_id          is 'The facility id';
comment on column ciip.production.operator_id          is 'The operator id';
comment on column ciip.production.product              is 'The product or processing unit module';
comment on column ciip.production.quantity             is 'The produced quantity';
comment on column ciip.production.units                is 'The units the quantity is reported in';
comment on column ciip.production.associated_emissions is 'The associated emissions (tCO2e)';

commit;