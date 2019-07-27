-- Revert ggircs:function_load_organisation from pg

begin;

drop function swrs_transform.load_organisation;

commit;
