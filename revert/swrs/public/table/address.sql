-- Revert ggircs:table_address from pg

begin;

drop table ggircs.address;

commit;
