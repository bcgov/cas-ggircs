-- Revert ggircs:table_ignore_organisation from pg

begin;

drop table ggircs_swrs.table_ignore_organisation;

commit;
