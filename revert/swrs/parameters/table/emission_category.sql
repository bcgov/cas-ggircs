-- Revert ggircs:swrs/parameters/table/emission_category from pg

begin;

drop table ggircs_parameters.emission_category;

commit;
