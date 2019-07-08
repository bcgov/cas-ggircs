-- Revert ggircs:ciip_table_production from pg

begin;

drop table ciip.production;

commit;