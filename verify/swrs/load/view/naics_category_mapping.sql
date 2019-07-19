-- Verify ggircs:view_naics_mapping on pg

begin;

select * from ggircs_swrs_load.naics_category_mapping where false;

commit;
