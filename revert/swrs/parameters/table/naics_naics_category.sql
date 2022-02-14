-- Revert ggircs:swrs/parameters/table/naics_naics_category from pg

begin;

drop table ggircs_parameters.naics_naics_category;

commit;
