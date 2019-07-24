-- Revert ggircs:table_ghgr_import from pg

begin;

drop table swrs_extract.ghgr_import;

commit;
