-- Revert ggircs:swrs/public/table/emission_003 from pg

begin;

alter table swrs.emission drop column ar5_calculated_quantity;

commit;
