-- Revert ggircs:swrs/parameters/table/naics_category from pg

begin;

drop table ggircs_parameters.naics_category;

commit;
