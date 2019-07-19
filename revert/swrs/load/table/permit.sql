-- Revert ggircs:table_permit from pg

begin;

drop table ggircs_swrs_load.permit;

commit;
