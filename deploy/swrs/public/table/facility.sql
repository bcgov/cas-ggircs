-- Deploy ggircs:table_facility to pg
-- requires: schema_ggircs

begin;

create table swrs.facility (
    id                        integer primary key,
    report_id                 integer references swrs.report(id),
    organisation_id           integer references swrs.organisation(id),
    parent_facility_id        integer references swrs.facility(id) deferrable initially immediate ,
    ghgr_import_id            integer,
    swrs_facility_id          integer,
    facility_name             varchar(1000),
    facility_type             varchar(1000),
    relationship_type         varchar(1000),
    portability_indicator     varchar(1000),
    status                    varchar(1000),
    latitude                  numeric,
    longitude                 numeric
);

create index ggircs_facility_organisation_foreign_key on swrs.facility(organisation_id);
create index ggircs_facility_report_foreign_key on swrs.facility(report_id);
create index ggircs_parent_facility_id_foreign_key on swrs.facility(parent_facility_id);

comment on table swrs.facility is 'the table housing all report data pertaining to the reporting facility';
comment on column swrs.facility.id is 'The primary key';
comment on column swrs.facility.report_id is 'A foreign key reference to swrs.report';
comment on column swrs.facility.organisation_id is 'A foreign key reference to swrs.organisation';
comment on column swrs.facility.parent_facility_id is 'A foreign key reference to swrs.lfo_facility';
comment on column swrs.facility.ghgr_import_id is 'The primary key for the materialized view';
comment on column swrs.facility.swrs_facility_id is 'The reporting facility swrs id';
comment on column swrs.facility.facility_name is 'The name of the reporting facility';
comment on column swrs.facility.facility_type is 'The type of the reporting facility';
comment on column swrs.facility.relationship_type is 'The type of relationship';
comment on column swrs.facility.portability_indicator is 'The portability indicator';
comment on column swrs.facility.status is 'The status of the facility';
comment on column swrs.facility.latitude is 'The latitude of the reporting facility';
comment on column swrs.facility.longitude is 'The longitude of the reporting facility';

commit;

