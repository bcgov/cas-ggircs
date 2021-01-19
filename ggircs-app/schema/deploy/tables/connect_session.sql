-- Deploy ggircs-app:tables/connect-session to pg

begin;

create table ggircs_app_private.connect_session (
  sid varchar(4093) not null collate "default",
  sess json not null,
  expire timestamp(6) not null
)
with (oids=false);

alter table ggircs_app_private.connect_session
  add constraint ggircs_app_private_session_pkey primary key (sid) not deferrable initially immediate;

create index ggircs_app_private_idx_session_expire
  on ggircs_app_private.connect_session(expire);

grant all on ggircs_app_private.connect_session to public;

comment on table ggircs_app_private.connect_session is 'The backing store for connect-pg-simple to store express session data';
comment on column ggircs_app_private.connect_session.sid is 'The value of the symmetric key encrypted connect.sid cookie';
comment on column ggircs_app_private.connect_session.sess is 'The express session middleware object picked as json containing the jwt';
comment on column ggircs_app_private.connect_session.expire is 'The timestamp after which this session object will be garbage collected';

commit;