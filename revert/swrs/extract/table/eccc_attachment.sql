-- Revert ggircs:swrs/extract/table/eccc_attachment from pg

begin;

drop table swrs_extract.eccc_attachment;

commit;
