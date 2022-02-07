-- Revert ggircs:swrs/public/table/emission_category from pg

begin;

drop table swrs.emission_category;

commit;
