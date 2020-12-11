-- Verify ggircs:swrs/transform/table/ignore_organisation_001 on pg

begin;

select exists(select 1 from swrs_transform.ignore_organisation where swrs_organisation_id=113130);
select exists(select 1 from swrs_transform.ignore_organisation where swrs_organisation_id=112552);

rollback;
