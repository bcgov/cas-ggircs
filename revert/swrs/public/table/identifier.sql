-- Revert ggircs:table_identifier from pg

begin;

drop table ggircs.identifier;

commit;
