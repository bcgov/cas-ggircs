-- Revert ggircs:materialized_view_address from pg

begin;

drop materialized view ggircs_swrs.address;

commit;
