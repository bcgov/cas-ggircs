-- Revert ggircs:swrs/extract/schema from pg

begin;

drop schema swrs_extract;

commit;
