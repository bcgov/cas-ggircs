-- Revert ggircs:materialized_view_permit from pg

begin;

drop materialized view ggircs_swrs.permit;

commit;
