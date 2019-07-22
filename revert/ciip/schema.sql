-- Revert ggircs:schema_ciip from pg

begin;

drop schema ciip;

commit;
