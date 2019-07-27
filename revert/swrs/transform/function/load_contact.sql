-- Revert ggircs:function_load_contact from pg

begin;

drop function swrs_transform.load_contact;

commit;
