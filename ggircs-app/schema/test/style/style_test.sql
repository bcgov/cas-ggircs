set client_min_messages to warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select plan(1);

-- Table exists
select has_table(
  'ggircs_app_private', 'connect_session',
  'ggircs_app_private.connect_session should exist, and be a table'
);

select finish();
rollback;
