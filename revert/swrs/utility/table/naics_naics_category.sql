-- Revert ggircs:swrs/utility/table/naics_naics_category from pg

begin;

drop table swrs_utility.naics_naics_category;

commit;
