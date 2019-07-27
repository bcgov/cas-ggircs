-- Revert ggircs:table_parent_organisation from pg

begin;

drop table swrs.parent_organisation;

commit;
