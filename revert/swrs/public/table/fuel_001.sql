-- Revert ggircs:swrs/public/table/fuel_001 from pg


begin;

alter table swrs.fuel drop column emission_category cascade;

commit;
