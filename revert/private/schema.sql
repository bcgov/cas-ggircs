-- Revert ggircs:private/schema from pg

begin;

drop schema swrs_private;

commit;
