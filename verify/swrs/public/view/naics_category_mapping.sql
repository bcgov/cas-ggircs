-- Verify ggircs:view_naics_mapping on pg

begin;

select * from swrs.naics_category_mapping where false;

commit;
