-- Deploy ggircs:table_permit to pg
-- requires: schema_ggircs

begin;

create table ggircs.permit (

    id                              integer primary key,
    ghgr_import_id                  integer,
    facility_id                     integer,
    path_context                    varchar(1000),
    issuing_agency                  varchar(1000),
    issuing_dept_agency_program     varchar(1000),
    permit_number                   varchar(1000)

);

comment on table ggircs.permit is 'The table housing permit information';
comment on column ggircs.permit.id is 'The primary key';
comment on column ggircs.permit.ghgr_import_id is 'The foreign key reference to ggircs.ghgr_import';
comment on column ggircs.permit.path_context is 'The context of the parent path (from VerifyTombstone or RegistrationData';
comment on column ggircs.permit.issuing_agency is 'The issuing agency for this permit';
comment on column ggircs.permit.issuing_dept_agency_program is 'The issuing agency program for this permit';
comment on column ggircs.permit.permit_number is 'The permit number';

commit;
