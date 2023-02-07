-- Revert ggircs:swrs/public/table/other_venting from pg

begin;

drop table swrs.other_venting;

commit;
