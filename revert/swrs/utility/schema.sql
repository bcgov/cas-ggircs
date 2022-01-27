-- Revert ggircs:swrs/utility/schema from pg

begin;

drop schema swrs_utility;

commit;
