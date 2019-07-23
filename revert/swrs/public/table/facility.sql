-- Revert ggircs:table_facility from pg

begin;

drop table swrs.facility;

commit;
