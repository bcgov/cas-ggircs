-- Revert ggircs:swrs/public/table/organisation_bc_registry_id from pg

begin;

drop table swrs.organisation_bc_registry_id;

commit;
