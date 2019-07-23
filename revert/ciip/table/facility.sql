-- Revert ggircs:ciip_table_facility from pg

begin;

drop table ciip_2018.facility;

commit;

