-- Deploy ggircs:ciip_table_emission to pg
-- requires: ciip_table_application


begin;

create table ciip.emission (
    id                        serial primary key,
    application_id            integer references ciip.application(id),
    quantity                  numeric,
    calculated_quantity       numeric,
    emission_category         varchar(1000)
);

create index ciip_emission_application_foreign_key on ciip.emission(application_id);

commit;
