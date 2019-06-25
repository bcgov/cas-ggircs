-- Verify ggircs:view_naics_mapping on pg

begin;

select * from ggircs.naics_category_mapping where false;

commit;
