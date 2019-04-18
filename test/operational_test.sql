set client_min_messages to warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;

select plan(0);

/** Check Operation Compliance **/

-- TODO: Hard DELETION of records is not recommended
        -- Soft DELETE the record and set a status or flag to indicate the record is “deleted”. I.e. is_deleted or deleted_ind

-- TODO: Changes to the data must be able to be audited

rollback;
