-- Revert ggircs:ciip_table_emission from pg

begin;

drop table ciip.emission;

commit;
