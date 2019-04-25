-- Revert ggircs:schema_ggircs_swrs from pg

begin;

drop schema ggircs_swrs;

commit;
