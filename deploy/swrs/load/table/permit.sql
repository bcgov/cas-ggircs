-- Deploy ggircs:table_permit to pg
-- requires: schema_ggircs

begin;

create table ggircs_swrs_load.permit (

    id                              integer primary key,
    ghgr_import_id                  integer,
    report_id                       integer references ggircs_swrs_load.report(id),
    facility_id                     integer references ggircs_swrs_load.facility(id),
    path_context                    varchar(1000),
    issuing_agency                  varchar(1000),
    issuing_dept_agency_program     varchar(1000),
    permit_number                   varchar(1000)

);

create index ggircs_permit_facility_foreign_key on ggircs_swrs_load.permit(facility_id);


comment on table ggircs_swrs_load.permit is 'The table housing permit information';
comment on column ggircs_swrs_load.permit.id is 'The primary key';
comment on column ggircs_swrs_load.permit.ghgr_import_id is 'The foreign key reference to ggircs_swrs_load.ghgr_import';
comment on column ggircs_swrs_load.permit.report_id is 'A foreign key reference to ggircs_swrs_load.report';
comment on column ggircs_swrs_load.permit.facility_id is 'A foreign key reference to ggircs_swrs_load.facility';
comment on column ggircs_swrs_load.permit.path_context is 'The context of the parent path (from VerifyTombstone or RegistrationData';
comment on column ggircs_swrs_load.permit.issuing_agency is 'The issuing agency for this permit';
comment on column ggircs_swrs_load.permit.issuing_dept_agency_program is 'The issuing agency program for this permit';
comment on column ggircs_swrs_load.permit.permit_number is 'The permit number';

commit;
