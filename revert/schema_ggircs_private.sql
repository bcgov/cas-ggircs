-- Revert ggircs:schema_ggircs_private from pg

begin;

drop schema ggircs_private;

commit;
