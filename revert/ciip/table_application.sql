-- Revert ggircs:ciip_table_application from pg

begin;

drop table ciip.application;

commit;
