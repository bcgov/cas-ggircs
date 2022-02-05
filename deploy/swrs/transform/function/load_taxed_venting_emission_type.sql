-- Deploy ggircs:swrs/transform/function/load_taxed_venting_emission_type to pg
-- requires: swrs/transform/schema
-- requires: swrs/public/table/taxed_venting_emission_type

begin;

drop function swrs_transform.load_taxed_venting_emission_type;

commit;
