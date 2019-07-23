-- Revert ggircs:ciip_table_production from pg

begin;

drop table ciip_2018.production;

commit;
