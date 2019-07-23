-- Revert ggircs:ciip_table_application from pg

begin;

drop table ciip_2018.application;

commit;
