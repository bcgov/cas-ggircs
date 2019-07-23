-- Revert ggircs:table_organisation from pg

begin;

drop table swrs.organisation;

commit;
