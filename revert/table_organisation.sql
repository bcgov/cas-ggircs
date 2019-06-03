-- Revert ggircs:table_organisation from pg

begin;

drop table ggircs.organisation;

commit;
