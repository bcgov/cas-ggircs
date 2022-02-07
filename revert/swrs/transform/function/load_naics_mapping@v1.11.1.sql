-- Revert ggircs:swrs/transform/function/load_naics_mapping from pg

begin;

drop function swrs_transform.load_naics_mapping;

commit;
