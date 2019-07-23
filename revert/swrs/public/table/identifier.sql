-- Revert ggircs:table_identifier from pg

begin;

drop table swrs.identifier;

commit;
