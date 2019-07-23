-- Revert ggircs:materialized_view_permit from pg

begin;

drop materialized view swrs_transform.permit;

commit;
