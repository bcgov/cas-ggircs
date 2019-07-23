-- Revert ggircs:table_address from pg

begin;

drop table swrs.address;

commit;
