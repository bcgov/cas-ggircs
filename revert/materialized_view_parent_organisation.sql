-- Revert ggircs:materialized_view_parent_organisation from pg

begin;

drop materialized view ggircs_swrs.parent_organisation;

commit;
