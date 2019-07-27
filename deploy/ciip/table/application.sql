-- Deploy ggircs:ciip_table_application to pg
-- requires: schema_ciip

begin;

create table ciip_2018.application
(
    id                        serial primary key,
    source_file_name          varchar(1000),
    source_sha1               varchar(1000),
    imported_at               timestamptz,
    application_year          varchar(1000),
    application_type          varchar(1000),
    signature_date            varchar(1000)
);

comment on table ciip_2018.application is 'The table containing the data representing an SIIP application form';
comment on column ciip_2018.application.id is 'The primary key';
comment on column ciip_2018.application.source_file_name is 'The name of the file the application was extracted from';
comment on column ciip_2018.application.source_sha1 is 'The sha1 hash of the file the application was extracted from';
comment on column ciip_2018.application.imported_at is 'The time at which the application was imported in the database';
comment on column ciip_2018.application.application_year is 'The reporting year of GHG emissions the application is for';
comment on column ciip_2018.application.application_type is 'The type of application, either SFO or LFO';
comment on column ciip_2018.application.signature_date is 'The date at which the application was electronically signed';

commit;
