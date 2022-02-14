-- Revert ggircs:swrs/transform/function/load_naics_category from pg

begin;

drop function swrs_transform.load_naics_category;

commit;
