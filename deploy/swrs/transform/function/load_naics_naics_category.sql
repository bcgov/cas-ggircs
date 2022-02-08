-- Deploy ggircs:swrs/transform/function/load_naics_naics_category to pg
-- requires: swrs/transform/schema
-- requires: swrs/public/table/naics_naics_category

begin;

drop function swrs_transform.load_naics_naics_category;

commit;
