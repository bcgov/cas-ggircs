-- Deploy ggircs:view_naics_mapping to pg
-- requires: table_naics
-- requires: table_naics_category
-- requires: table_naics_naics_category

begin;

create or replace view ggircs.naics_category_mapping as
    with distinct_naics_code_list as (
        select distinct(naics_code),
                       _naics_category.naics_category,
                       _naics_category_type.naics_category_type,
                       _nnc.category_id,
                       _nnc.category_type_id
        from ggircs.naics
                 join ggircs_swrs.naics_naics_category as _nnc
                      on naics_code::text like naics_code_pattern || '%'
                 left join ggircs_swrs.naics_category as _naics_category
                           on _nnc.category_id = _naics_category.id
                 left join ggircs.naics_category_type as _naics_category_type
                           on _nnc.category_type_id = _naics_category_type.id
    ) select d.naics_code, d.naics_category, d.naics_category_type, d.category_id as naics_category_id, d.category_type_id as naics_category_type_id, _report.id as report_id, _facility.id as facility_id
      from ggircs.naics
        inner join distinct_naics_code_list as d
            on naics.naics_code = d.naics_code
        join ggircs.report as _report
            on naics.report_id = _report.id
        join ggircs.facility as _facility
            on naics.facility_id = _facility.id
        group by d.naics_code, d.naics_category, d.naics_category_type, d.category_id, d.category_type_id, _report.id, _facility.id;
commit;

