-- Revert ggircs:swrs/public/view/fuel_mapping from pg

begin;

drop view if exists swrs.fuel_mapping;

commit;
