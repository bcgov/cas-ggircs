SET client_min_messages TO warning;
CREATE extension IF NOT EXISTS pgtap;
RESET client_min_messages;

BEGIN;

SELECT plan(0);

/** Check Operation Compliance **/

-- TODO: Hard DELETION of records is not recommended
        -- Soft DELETE the record and set a status or flag to indicate the record is “deleted”. I.e. is_deleted or deleted_ind

-- TODO: Changes to the data must be able to be audited

ROLLBACK;
