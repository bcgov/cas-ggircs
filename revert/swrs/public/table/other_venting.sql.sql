-- Revert ggircs:swrs/public/table/other_venting.sql from pg

begin;

drop table swrs.other_venting;

commit;
