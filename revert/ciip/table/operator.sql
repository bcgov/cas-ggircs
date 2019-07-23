-- Revert ggircs:ciip_table_operator from pg

begin;

drop table ciip_2018.operator;

commit;
