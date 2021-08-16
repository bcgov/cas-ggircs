-- Revert ggircs:swrs/extract/table/eccc_attachments from pg

begin;

drop table swrs_extract.eccc_attachments;

commit;
