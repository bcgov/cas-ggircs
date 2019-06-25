-- Revert ggircs:table_facility from pg

begin;

drop table ggircs.facility;

commit;
