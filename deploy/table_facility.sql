-- Deploy ggircs:table_facility to pg
-- requires: schema_ggircs

begin;

create table ggircs.facility (

    id                        int generated always as identity primary key,
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

comment on table ggircs.facility is 'the table housing all report data pertaining to the reporting facility';
comment on column ggircs.facility.ghgr_import_id is 'The primary key for the materialized view';
comment on column ggircs.facility.swrs_facility_id is 'The reporting facility swrs id';
comment on column ggircs.facility.facility_name is 'The name of the reporting facility';
comment on column ggircs.facility.facility_type is 'The type of the reporting facility';
comment on column ggircs.facility.relationship_type is 'The type of relationship';
comment on column ggircs.facility.portability_indicator is 'The portability indicator';
comment on column ggircs.facility.status is 'The status of the facility';
comment on column ggircs.facility.latitude is 'The latitude of the reporting facility';
comment on column ggircs.facility.longitude is 'The longitude of the reporting facility';

commit;
