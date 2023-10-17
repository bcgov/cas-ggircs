-- Deploy ggircs:swrs/public/table/emission_004 to pg
-- requires: swrs/public/table/emission_003

begin;

alter table swrs.emission add electricity_amount numeric;

comment on column swrs.emission.electricity_amount is 'The amount of electricity imported/exported for the row data';

commit;
