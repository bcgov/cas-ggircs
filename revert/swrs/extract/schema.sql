-- Revert ggircs:swrs/extract/schema from pg

begin;

drop schema ggircs_swrs_extract;

commit;
