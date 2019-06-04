-- Deploy ggircs:table_naics to pg
-- requires: schema_ggircs

begin;

create table ggircs.naics (

    id                        int generated always as identity primary key,
    ghgr_import_id            integer,
    swrs_facility_id          integer,
    path_context              varchar(1000),
    naics_classification      varchar(1000),
    naics_code                integer,
    naics_priority            varchar(1000)

);

comment on table ggircs.naics is 'The table housing all report data pertaining to naics';
comment on column ggircs.naics.id is 'The primary key';
comment on column ggircs.naics.ghgr_import_id is 'The foreign key reference to ggircs.ghgr_import.id';
comment on column ggircs.naics.swrs_facility_id is 'The reporting facility swrs id, fk to ggircs.facility';
comment on column ggircs.naics.path_context is 'The ancestor context from which this naics code was selected (from VerifyTombstone or RegistrationData)';
comment on column ggircs.naics.naics_classification is 'The naics classification';
comment on column ggircs.naics.naics_code is 'The naics code';
comment on column ggircs.naics.naics_priority is 'The naics priority';

commit;
