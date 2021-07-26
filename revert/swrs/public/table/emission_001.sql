-- Revert ggircs:swrs/public/table/emission_001 from pg

begin;

alter table swrs.emission drop column cas_number;

commit;
