-- Revert ggircs:table_fuel from pg

begin;

drop table swrs.fuel;

commit;
