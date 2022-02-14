-- Deploy ggircs:swrs/transform/function/load_emission_category to pg
-- requires: swrs/transform/schema
-- requires: swrs/public/table/emission_category

begin;

drop function swrs_transform.load_emission_category;

commit;
