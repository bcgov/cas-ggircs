-- Deploy ggircs:view_facility_details to pg
-- requires: schema_ggircs
-- requires: table_facility
-- requires: table_organisation
-- requires: table_naics
-- requires: table_naics_mapping
-- requires: table_identifier

begin;

create or replace view ggircs.facility_details as
    with distinct_naics_code_list as (
        select distinct(naics_code) as naics_code,
                       _naics_category.naics_category,
                       _naics_category_type.naics_category_type,
                       _nnc.category_id,
                       _nnc.category_type_id
        from ggircs.naics
                 join ggircs.naics_naics_category as _nnc
                      on naics_code::text like naics_code_pattern || '%'
                 left join ggircs.naics_category as _naics_category
                           on _nnc.category_id = _naics_category.id
                 left join ggircs.naics_category_type as _naics_category_type
                           on _nnc.category_type_id = _naics_category_type.id
    ),
    naics_category_mapping as (
        select d.naics_code, d.naics_category, d.naics_category_type, d.category_id as naics_category_id, d.category_type_id as naics_category_type_id, _report.id as report_id, _facility.id as facility_id
        from ggircs.naics
            inner join distinct_naics_code_list as d
                on naics.naics_code = d.naics_code
            join ggircs.report as _report
                on naics.report_id = _report.id
            join ggircs.facility as _facility
                on naics.facility_id = _facility.id
            group by d.naics_code, d.naics_category, d.naics_category_type, d.category_id, d.category_type_id, _report.id, _facility.id
    )
select
       _facility.*,
       _naics.id as naics_id,
       _naics_category_hhw.naics_category as hhw_category,
       _naics_category_irc.naics_category as irc_category,
       _naics.naics_classification,
       _naics.naics_code,
       _identifier.identifier_value

from ggircs.facility as _facility
       left join ggircs.organisation as _organisation on _facility.organisation_id = _organisation.id
       left join ggircs.naics as _naics on _facility.id = _naics.registration_data_facility_id
       left join ggircs.identifier as _identifier on _facility.id = _identifier.facility_bcghgid_id
       left join naics_category_mapping as _naics_category_hhw
           on _naics_category_hhw.naics_code = _naics.naics_code
           and _naics_category_hhw.naics_category_type = 'hhw'
           and _naics_category_hhw.facility_id = _naics.registration_data_facility_id
       left join naics_category_mapping as _naics_category_irc
           on _naics_category_irc.naics_code = _naics.naics_code
           and _naics_category_irc.naics_category_type = 'irc'
           and _naics_category_irc.facility_id = _naics.registration_data_facility_id;
commit;
