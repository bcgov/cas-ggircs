-- Revert ggircs:materialized_view_flat from pg

begin;

drop materialized view swrs_transform.flat;

commit;
