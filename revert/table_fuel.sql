-- Revert ggircs:table_fuel from pg

begin;

-- Todo: Remove this drop table statement when attributable_emission is refactored to a view
drop table if exists ggircs.attributable_emission;
drop table ggircs.fuel;

commit;
