-- Revert ggircs:swrs/parameters/schema from pg

begin;

drop schema ggircs_parameters;

commit;
