-- Deploy ggircs:swrs/public/view/naics_category to pg
-- requires: swrs/parameters/table/naics_category

begin;

create or replace view swrs.naics_category as (
  select * from ggircs_parameters.naics_category
);

comment on view swrs.naics_category is 'A view that retrieves the data from the ggircs_parameters.naics_category table. This view is necessary to maintain relationships defined elsewhere like CIIP and metabase after the table was moved to the ggircs_parameters schema';
comment on column swrs.naics_category.id is 'The internal primary key for the mapping';
comment on column swrs.naics_category.naics_category is 'The naics category';

commit;
