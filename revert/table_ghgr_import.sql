-- Revert ggircs:table_ghgr_import from pg

begin;

drop table ggircs_swrs.ghgr_import;

commit;
