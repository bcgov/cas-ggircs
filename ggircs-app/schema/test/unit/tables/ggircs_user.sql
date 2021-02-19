set client_min_messages to warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select plan(2);

-- Table exists
select has_table(
  'ggircs_app', 'ggircs_user',
  'ggircs_app.ggircs_user should exist, and be a table'
);

select has_index(
  'ggircs_app',
  'ggircs_user',
  'ggircs_user_uuid',
  'ggircs_user has index: ggircs_user_uuid' );

select finish();
rollback;
