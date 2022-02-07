-- Deploy ggircs:swrs/transform/function/load_naics_category_type to pg
-- requires: swrs/transform/schema
-- requires: swrs/public/table/naics_category_type

begin;

drop function swrs_transform.load_naics_category_type;

commit;
