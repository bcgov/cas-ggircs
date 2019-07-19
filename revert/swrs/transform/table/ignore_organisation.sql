-- Revert ggircs:ignore_organisation from pg

begin;

drop table ggircs_swrs_transform.ignore_organisation;

commit;
