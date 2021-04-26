-- Revert ggircs:swrs/public/table/facility_001 from pg

begin;

alter table swrs.facility drop column facility_bc_ghg_id cascade;

commit;
