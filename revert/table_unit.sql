-- Revert ggircs:table_unit from pg

begin;

drop table ggircs.unit;

commit;
