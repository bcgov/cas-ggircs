-- Revert ggircs:view_attributable_emission from pg

begin;

drop view if exists swrs.attributable_emission;

commit;
