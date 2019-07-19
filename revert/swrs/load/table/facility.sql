-- Revert ggircs:table_facility from pg

begin;

drop table ggircs_swrs_load.facility;

commit;
