-- Revert ggircs:ciip_table_emission from pg

begin;

drop table ciip_2018.emission;

commit;
