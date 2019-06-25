-- Deploy ggircs:table_identifier to pg
-- requires: schema_ggircs

begin;

create table ggircs.identifier(

    id                              integer primary key,
    ghgr_import_id                  integer,
    report_id                       integer references ggircs.report (id),
    facility_id                     integer references ggircs.facility(id),
    facility_bcghgid_id             integer references ggircs.facility(id),
    swrs_facility_id                integer,
    path_context                    varchar(1000),
    identifier_type                 varchar(1000),
    identifier_value                varchar(1000)
);

create index ggircs_identifier_report_foreign_key on ggircs.identifier(report_id);
create index ggircs_identifier_facility_foreign_key on ggircs.identifier(facility_id);
create index ggircs_identifier_facility_bcghgid_foreign_key on ggircs.identifier(facility_bcghgid_id);

comment on table ggircs.identifier is 'The table housing information regarding identifiers';
comment on column ggircs.identifier.id is 'The primary key';
comment on column ggircs.identifier.ghgr_import_id is 'The foreign key referencing ggrics_swrs.ghgr_import.id';
comment on column ggircs.identifier.facility_bcghgid_id is 'A foreign key reference to ggircs.facility with correct bcghgid';
comment on column ggircs.identifier.facility_id is 'A foreign key reference to ggircs.facility';
comment on column ggircs.identifier.report_id is 'A foreign key reference to ggircs.report';
comment on column ggircs.identifier.swrs_facility_id is 'The swrs facility id';
comment on column ggircs.identifier.path_context is 'The path context to the Identifier node (from VerifyTombstone or RegistrationDetails)';
comment on column ggircs.identifier.identifier_type is 'The type of identifier';
comment on column ggircs.identifier.identifier_value is 'The value of the identifier';

commit;
