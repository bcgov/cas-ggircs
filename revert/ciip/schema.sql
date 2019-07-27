-- Revert ggircs:schema_ciip from pg

begin;

drop schema ciip_2018;

commit;
