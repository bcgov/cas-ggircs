-- Deploy ggircs:ciip_table_application to pg
-- requires: schema_ciip

begin;

create table ciip.application
(
    id                        serial primary key,
    source_file_name          varchar(1000),
    source_sha1               varchar(1000),
    imported_at               timestamptz,
    swrs_facility_id          integer,
    swrs_organisation_id      integer,
    application_year          varchar(1000),
    signature_date            varchar(1000)
);

comment on table ciip.application is 'The table containing the data representing an SIIP application form';
comment on column ciip.application.id is 'The primary key';

commit;
