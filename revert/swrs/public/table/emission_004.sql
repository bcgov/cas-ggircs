-- Revert ggircs:swrs/public/table/emission_004 from pg

begin;

alter table swrs.emission drop column electricity_amount;

commit;
