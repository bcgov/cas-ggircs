-- Revert ggircs:ciip_table_address from pg

begin;

drop table ciip_2018.address;

commit;
