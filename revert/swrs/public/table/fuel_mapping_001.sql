-- Revert ggircs:swrs/public/table/fuel_mapping_001 from pg

begin;

drop index swrs.fuel_mapping_ct_details_foreign_key;

commit;
