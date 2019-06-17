-- Revert ggircs:view_attributable_emission from pg

begin;

drop view if exists ggircs.attributable_emission;

commit;
