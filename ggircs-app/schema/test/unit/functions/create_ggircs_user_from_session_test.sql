set client_min_messages to warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select plan(2);

select has_function(
  'ggircs_app', 'create_ggircs_user_from_session',
  'Function create_ggircs_user_from_session should exist'
);

-- Add a user via create_ggircs_user_from_session()
set jwt.claims.sub to '11111111-1111-1111-1111-111111111111';
select ggircs_app.create_ggircs_user_from_session();

select isnt_empty (
  $$
    select * from ggircs_app.ggircs_user where uuid = '11111111-1111-1111-1111-111111111111'::uuid;
  $$,
  'crreate_ggircs_user_from_session() successfully creates a user'
);

select finish();
rollback;
