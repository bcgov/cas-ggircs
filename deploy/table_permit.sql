-- Deploy ggircs:table_permit to pg
-- requires: schema_ggircs

begin;

create table ggircs.permit (

    id                              integer primary key,
    ghgr_import_id                  integer,
    single_facility_id              integer references ggircs.single_facility(id),
    lfo_facility_id                 integer references ggircs.lfo_facility(id),
    path_context                    varchar(1000),
    issuing_agency                  varchar(1000),
    issuing_dept_agency_program     varchar(1000),
    permit_number                   varchar(1000)

);

create index ggircs_permit_single_facility_foreign_key on ggircs.permit(single_facility_id);
create index ggircs_permit_lfo_facility_foreign_key on ggircs.permit(lfo_facility_id);

comment on table ggircs.permit is 'The table housing permit information';
comment on column ggircs.permit.id is 'The primary key';
comment on column ggircs.permit.ghgr_import_id is 'The foreign key reference to ggircs.ghgr_import';
comment on column ggircs.permit.single_facility_id is 'A foreign key reference to ggircs.single_facility';
comment on column ggircs.permit.lfo_facility_id is 'A foreign key reference to ggircs.lfo_facility';
comment on column ggircs.permit.path_context is 'The context of the parent path (from VerifyTombstone or RegistrationData';
comment on column ggircs.permit.issuing_agency is 'The issuing agency for this permit';
comment on column ggircs.permit.issuing_dept_agency_program is 'The issuing agency program for this permit';
comment on column ggircs.permit.permit_number is 'The permit number';

commit;
