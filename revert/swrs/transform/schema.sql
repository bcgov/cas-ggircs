-- Revert ggircs:swrs/transform/schema from pg

begin;

drop schema ggircs_swrs_transform;

commit;
