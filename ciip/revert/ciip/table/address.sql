-- Revert ggircs:ciip_table_address from pg

begin;

drop table ciip.address;

commit;
