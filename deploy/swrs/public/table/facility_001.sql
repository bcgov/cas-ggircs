-- Deploy ggircs:swrs/public/table/facility_001 to pg

begin;

alter table swrs.facility add column facility_bc_ghg_id varchar(1000);

comment on column swrs.facility.facility_bc_ghg_id is 'The BC GHG ID of the reporting facility';

commit;
