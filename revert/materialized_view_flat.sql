-- Revert ggircs:materialized_view_flat from pg

begin;

drop materialized view ggircs_swrs.flat;

commit;
