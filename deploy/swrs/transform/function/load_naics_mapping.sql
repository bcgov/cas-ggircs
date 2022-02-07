-- Deploy ggircs:swrs/transform/function/load_naics_mapping to pg
-- requires: swrs/transform/schema
-- requires: swrs/public/table/naics_mapping

begin;

drop function swrs_transform.load_naics_mapping;

commit;
