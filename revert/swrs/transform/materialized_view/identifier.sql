-- Revert ggircs:materialized_view_identifier from pg

begin;

drop materialized view ggircs_swrs_transform.identifier;

commit;
