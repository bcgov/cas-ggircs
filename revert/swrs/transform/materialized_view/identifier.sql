-- Revert ggircs:materialized_view_identifier from pg

begin;

drop materialized view swrs_transform.identifier;

commit;
