set client_min_messages to warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;

select plan(0);

rollback;
