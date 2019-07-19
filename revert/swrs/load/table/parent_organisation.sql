-- Revert ggircs:table_parent_organisation from pg

begin;

drop table ggircs_swrs_load.parent_organisation;

commit;
