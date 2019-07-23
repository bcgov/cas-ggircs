-- Verify ggircs:ciip/view_compare_ciip_swrs_emission on pg

begin;

select * from ciip_2018.compare_ciip_swrs_emission where false;

rollback;
