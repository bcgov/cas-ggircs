-- Deploy ggircs:view_naics_mapping to pg
-- requires: table_naics
-- requires: table_naics_category
-- requires: table_naics_naics_category

begin;

create or replace view ggircs.naics_category_mapping as

    select naics.naics_code, _naics_category_hhw.naics_category as hhw_category, _naics_category_irc.naics_category as irc_category
        from ggircs.naics
            join ggircs_swrs.naics_naics_category as _naics_naics_category
                on naics.naics_category_id = _naics_naics_category.id
            join ggircs_swrs.naics_category as _naics_category_hhw
                on _naics_naics_category.hhw_category_id = _naics_category_hhw.id
            join ggircs_swrs.naics_category as _naics_category_irc
                on _naics_naics_category.irc_category_id = _naics_category_irc.id
            join ggircs.report as _report
                on naics.report_id = _report.id
            join ggircs.facility as _facility
                on naics.facility_id = _facility.id;
commit;

