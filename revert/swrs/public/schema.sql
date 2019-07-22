-- Revert ggircs:swrs/public/schema from pg

begin;

drop schema ggircs;

commit;
