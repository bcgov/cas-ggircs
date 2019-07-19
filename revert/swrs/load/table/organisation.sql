-- Revert ggircs:table_organisation from pg

begin;

drop table ggircs_swrs_load.organisation;

commit;
