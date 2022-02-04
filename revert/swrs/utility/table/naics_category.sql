-- Revert ggircs:swrs/utility/table/naics_category from pg

begin;

drop table swrs_utility.naics_category;

commit;
