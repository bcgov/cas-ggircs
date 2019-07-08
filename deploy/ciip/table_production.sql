-- Deploy ggircs:ciip_table_production to pg
-- requires: ciip_table_application
begin;

create table ciip.production
(
    id                        serial primary key,
    application_id            integer references ciip.application(id),
    product                   varchar(1000),
    quantity                  numeric,
    units                     varchar(1000),
    associated_emissions      numeric
);

create index ciip_production_application_foreign_key on ciip.production(application_id);

commit;