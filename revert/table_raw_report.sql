-- Revert ggircs:table_raw_report from pg

BEGIN;

<<<<<<< befe56446eca5496e608064ee84ec21d33baf225
drop table ggircs_private.raw_report;
=======
-- XXX Add DDLs here.
>>>>>>> added table_raw_report to plan and created deploy revert verify skeleton files

COMMIT;
