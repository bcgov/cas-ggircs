-- Revert ggircs:swrs/load/schema from pg

begin;

drop schema ggircs_swrs_load;

commit;
