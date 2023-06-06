-- Deploy ggircs:swrs/public/table/emission_003 to pg

begin;

alter table swrs.emission add ar5_calculated_quantity numeric;

comment on column swrs.emission.cas_number is 'AR5 calculated quantity value which is calculated by quantity x gwp(AR5 value)';

commit;
