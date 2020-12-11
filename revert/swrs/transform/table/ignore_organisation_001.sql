-- Revert ggircs:swrs/transform/table/ignore_organisation_001 from pg

begin;

delete from swrs_transform.ignore_organisation where swrs_organisation_id in (113130), (112552);

commit;
