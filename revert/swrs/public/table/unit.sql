-- Revert ggircs:table_unit from pg

begin;

drop table swrs.unit;

commit;
