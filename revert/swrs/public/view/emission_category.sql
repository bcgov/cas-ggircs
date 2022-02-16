-- Revert ggircs:swrs/public/view/emission_category from pg

begin;

drop view if exists swrs.emission_category;

commit;
