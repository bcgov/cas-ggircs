-- Deploy ggircs:swrs/public/table/organisation_bc_registry_id to pg

begin;

create table swrs.organisation_bc_registry_id (
  swrs_organisation_id int not null primary key,
  bc_registry_id varchar(1000) not null
);

comment on table swrs.organisation_bc_registry_id is 'A table listing the BC Registry ID for each organisation';
comment on column swrs.organisation_bc_registry_id.swrs_organisation_id is 'The SWRS ID of the organisation';
comment on column swrs.organisation_bc_registry_id.bc_registry_id is 'The BC Registry ID of the organisation';

commit;
