-- Revert ggircs:swrs/transform/function/load_naics_category_type from pg

begin;

drop function swrs_transform.load_naics_category_type;

commit;
