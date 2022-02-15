-- Revert ggircs:swrs/public/view/naics_category from pg

begin;

drop view if exists swrs.naics_category;

commit;
