-- Revert ggircs:table_ghgr_import from pg

begin;

drop table ggircs_swrs_extract.ghgr_import;

commit;
