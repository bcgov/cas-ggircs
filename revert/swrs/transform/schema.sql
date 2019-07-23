-- Revert ggircs:swrs/transform/schema from pg

begin;

drop schema swrs_transform;

commit;
