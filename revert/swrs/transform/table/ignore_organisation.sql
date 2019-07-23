-- Revert ggircs:ignore_organisation from pg

begin;

drop table swrs_transform.ignore_organisation;

commit;
