-- Revert ggircs:swrs/utility/table/emission_category from pg

begin;

drop table swrs_utility.emission_category;

commit;
