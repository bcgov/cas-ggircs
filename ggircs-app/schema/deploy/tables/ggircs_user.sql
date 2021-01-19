-- Deploy ggircs-app:tables/ggircs_user to pg

begin;

create table ggircs_app.ggircs_user
(
  id integer primary key generated always as identity,
  uuid uuid not null,
  first_name varchar(1000),
  last_name varchar(1000),
  email_address varchar(1000),
  created_at timestamp with time zone not null default now(),
  created_by int references ggircs_app.ggircs_user,
  updated_at timestamp with time zone not null default now(),
  updated_by int references ggircs_app.ggircs_user,
  deleted_at timestamp with time zone,
  deleted_by int references ggircs_app.ggircs_user

);

create trigger _100_timestamps
  before insert or update on ggircs_app.ggircs_user
  for each row
  execute procedure ggircs_app_private.update_timestamps();

create unique index ggircs_user_uuid on ggircs_app.ggircs_user(uuid);

do
$grant$
begin
-- Grant ggircs_user permissions
perform ggircs_app_private.grant_permissions('select', 'ggircs_user', 'ggircs_user');
perform ggircs_app_private.grant_permissions('insert', 'ggircs_user', 'ggircs_user');
perform ggircs_app_private.grant_permissions('update', 'ggircs_user', 'ggircs_user',
  ARRAY['first_name', 'last_name', 'email_address', 'created_at', 'created_by', 'updated_at', 'updated_by', 'deleted_at', 'deleted_by']);

-- Grant ggircs_guest permissions
perform ggircs_app_private.grant_permissions('select', 'ggircs_user', 'ggircs_guest');

end
$grant$;

-- Enable row-level security
alter table ggircs_app.ggircs_user enable row level security;

do
$policy$
begin
-- ggircs_user RLS: can see all users, but can only modify its own record
perform ggircs_app_private.upsert_policy('ggircs_user_select_ggircs_user', 'ggircs_user', 'select', 'ggircs_user', 'true');
perform ggircs_app_private.upsert_policy('ggircs_user_insert_ggircs_user', 'ggircs_user', 'insert', 'ggircs_user', 'uuid=(select sub from ggircs_app.session())');
perform ggircs_app_private.upsert_policy('ggircs_user_update_ggircs_user', 'ggircs_user', 'update', 'ggircs_user', 'uuid=(select sub from ggircs_app.session())');

-- ggircs_guest RLS: can only see its own record
-- perform ggircs_app_private.upsert_policy('ggircs_guest_select_ggircs_user', 'ggircs_user', 'select', 'ggircs_guest', 'uuid=(select sub from ggircs_app.session())');

end
$policy$;

comment on table ggircs_app.ggircs_user is 'Table containing the benchmark and eligibility threshold for a product';
comment on column ggircs_app.ggircs_user.id is 'Unique ID for the user';
comment on column ggircs_app.ggircs_user.uuid is 'Universally Unique ID for the user, defined by the single sign-on provider';
comment on column ggircs_app.ggircs_user.first_name is 'User''s first name';
comment on column ggircs_app.ggircs_user.last_name is 'User''s last name';
comment on column ggircs_app.ggircs_user.email_address is 'User''s email address';
comment on column ggircs_app.ggircs_user.created_at is 'The date this record was inserted';
comment on column ggircs_app.ggircs_user.created_by is 'The foreign key to the user id that created this record';
comment on column ggircs_app.ggircs_user.updated_at is 'The date this record was last updated';
comment on column ggircs_app.ggircs_user.updated_by is 'The foreign key to the user id that last updated this record';
comment on column ggircs_app.ggircs_user.deleted_at is 'The date this record was deleted';
comment on column ggircs_app.ggircs_user.deleted_by is 'The foreign key to the user id that deleted this record';

commit;
