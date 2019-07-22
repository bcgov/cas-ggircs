-- Revert ggircs:table_parent_organisation from pg

begin;

drop table ggircs.parent_organisation;

commit;
