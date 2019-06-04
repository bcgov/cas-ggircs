-- Revert ggircs:table_fuel from pg

begin;

drop table ggircs.fuel;

commit;
