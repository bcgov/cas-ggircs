-- Deploy ggircs:table_naics to pg
-- requires: schema_ggircs

begin;

create table swrs.naics (

    id                                      integer primary key,
    ghgr_import_id                          integer,
    report_id                               integer references swrs.report(id),
    facility_id                             integer references swrs.facility(id),
    registration_data_facility_id           integer references swrs.facility(id),
    swrs_facility_id                        integer,
    path_context                            varchar(1000),
    naics_classification                    varchar(1000),
    naics_code                              integer,
    naics_priority                          varchar(1000)

);

create index ggircs_naics_report_foreign_key on swrs.naics(report_id);
create index ggircs_naics_facility_foreign_key on swrs.naics(facility_id);
create index ggircs_naics_registration_data_facility_foreign_key on swrs.naics(facility_id);

comment on table swrs.naics is 'The table housing all report data pertaining to naics';
comment on column swrs.naics.id is 'The primary key';
comment on column swrs.naics.ghgr_import_id is 'The foreign key reference to swrs.ghgr_import.id';
comment on column swrs.naics.report_id is 'A foreign key reference to swrs.report';
comment on column swrs.naics.facility_id is 'A foreign key reference to swrs.facility';
comment on column swrs.naics.registration_data_facility_id is 'A foreign key reference to swrs.facility where naics path context = RegistrationData';
comment on column swrs.naics.swrs_facility_id is 'The reporting facility swrs id, fk to swrs.facility';
comment on column swrs.naics.path_context is 'The ancestor context from which this naics code was selected (from VerifyTombstone or RegistrationData)';
comment on column swrs.naics.naics_classification is 'The naics classification';
comment on column swrs.naics.naics_code is 'The naics code';
comment on column swrs.naics.naics_priority is 'The naics priority';

commit;
