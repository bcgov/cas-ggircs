-- Deploy ggircs:table_naics to pg
-- requires: schema_ggircs

begin;

create table ggircs.naics (

    id                                      integer primary key,
    ghgr_import_id                          integer,
    report_id                               integer references ggircs.report(id),
    single_facility_id                      integer references ggircs.single_facility(id),
    lfo_facility_id                         integer references ggircs.lfo_facility(id),
    registration_data_single_facility_id    integer references ggircs.single_facility(id),
    registration_data_lfo_facility_id       integer references ggircs.lfo_facility(id),
    naics_mapping_id                        integer references ggircs_swrs.naics_mapping(id),
    swrs_facility_id                        integer,
    path_context                            varchar(1000),
    naics_classification                    varchar(1000),
    naics_code                              integer,
    naics_priority                          varchar(1000)

);

create index ggircs_naics_report_foreign_key on ggircs.naics(report_id);
create index ggircs_naics_single_facility_foreign_key on ggircs.naics(single_facility_id);
create index ggircs_naics_lfo_facility_foreign_key on ggircs.naics(lfo_facility_id);
create index ggircs_naics_registration_data_single_facility_foreign_key on ggircs.naics(single_facility_id);
create index ggircs_naics_registration_data_lfo_facility_foreign_key on ggircs.naics(lfo_facility_id);
create index ggircs_naics_naics_mapping_foreign_key on ggircs.naics(naics_mapping_id);

comment on table ggircs.naics is 'The table housing all report data pertaining to naics';
comment on column ggircs.naics.id is 'The primary key';
comment on column ggircs.naics.ghgr_import_id is 'The foreign key reference to ggircs.ghgr_import.id';
comment on column ggircs.naics.report_id is 'A foreign key reference to ggircs.report';
comment on column ggircs.naics.single_facility_id is 'A foreign key reference to ggircs.single_facility';
comment on column ggircs.naics.lfo_facility_id is 'A foreign key reference to ggircs.lfo_facility';
comment on column ggircs.naics.registration_data_single_facility_id is 'A foreign key reference to ggircs.single_facility where naics path context = RegistrationData';
comment on column ggircs.naics.registration_data_lfo_facility_id is 'A foreign key reference to ggircs.lfo_facility where naics path context = RegistrationData';
comment on column ggircs.naics.naics_mapping_id is 'A foreign key reference to ggircs_swrs.naics_mapping';
comment on column ggircs.naics.swrs_facility_id is 'The reporting facility swrs id, fk to ggircs.facility';
comment on column ggircs.naics.path_context is 'The ancestor context from which this naics code was selected (from VerifyTombstone or RegistrationData)';
comment on column ggircs.naics.naics_classification is 'The naics classification';
comment on column ggircs.naics.naics_code is 'The naics code';
comment on column ggircs.naics.naics_priority is 'The naics priority';

commit;
