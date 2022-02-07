-- Deploy ggircs:view_naics_mapping to pg
-- requires: table_naics
-- requires: table_naics_category
-- requires: table_naics_naics_category

begin;

drop view swrs.naics_category_mapping;

commit;
