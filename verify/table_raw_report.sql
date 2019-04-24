-- Verify ggircs:table_raw_report on pg

BEGIN;

<<<<<<< befe56446eca5496e608064ee84ec21d33baf225
select pg_catalog.has_table_privilege('ggircs_private.raw_report', 'select');
=======
-- XXX Add verifications here.
>>>>>>> added table_raw_report to plan and created deploy revert verify skeleton files

ROLLBACK;
