-- Revert ggircs:materialized_view_contact from pg

begin;

drop materialized view swrs_transform.contact;

commit;
