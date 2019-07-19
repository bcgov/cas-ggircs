-- Revert ggircs:table_address from pg

begin;

drop table ggircs_swrs_load.address;

commit;
