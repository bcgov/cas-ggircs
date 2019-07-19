-- Revert ggircs:function_load_contact from pg

begin;

drop function ggircs_swrs_transform.load_contact;

commit;
