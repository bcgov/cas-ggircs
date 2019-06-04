-- Revert ggircs:table_descriptor from pg

begin;

drop table ggircs.descriptor;

commit;
