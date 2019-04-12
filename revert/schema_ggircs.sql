-- Revert ggircs:schema_ggircs from pg

begin;

drop schema ggircs;

commit;
