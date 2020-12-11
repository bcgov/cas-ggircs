-- Deploy ggircs:swrs/transform/table/ignore_organisation_001 to pg
-- requires: swrs/transform/table/ignore_organisation

-- Deploy ggircs:ignore_organisation to pg
-- requires: schema_ggircs_swrs

begin;

insert into swrs_transform.ignore_organisation (swrs_organisation_id)
values (113130), (112552)
on conflict (swrs_organisation_id) do nothing;

commit;
