-- Revert ggircs:function_load_parent_organisation from pg

begin;

drop function swrs_transform.load_parent_organisation;

commit;
