-- Deploy ggircs:table_parent_organisation to pg
-- requires: schema_ggircs

begin;

create table ggircs.parent_organisation (

    id                        integer primary key,
    ghgr_import_id            integer,
    organisation_id                 integer,
    report_id                 integer,
    path_context              varchar(1000),
    percentage_owned          numeric,
    french_trade_name         varchar(1000),
    english_trade_name        varchar(1000),
    duns                      varchar(1000),
    business_legal_name       varchar(1000),
    website                   varchar(1000)
);

comment on table ggircs.parent_organisation is 'The table housing parent organisation information';
comment on column ggircs.parent_organisation.id is 'The primary key';
comment on column ggircs.parent_organisation.ghgr_import_id is 'The foreign key reference to ggircs.ghgr_import';
comment on column ggircs.parent_organisation.organisation_id is 'A foreign key reference to ggircs.organisation';
comment on column ggircs.parent_organisation.report_id is 'A foreign key reference to ggircs.report';
comment on column ggircs.parent_organisation.path_context is 'The path context used to reach the ParentOrganisation node (VerifyTombstone or RegistrationData';
comment on column ggircs.parent_organisation.percentage_owned is 'The % owned by this parent organisation';
comment on column ggircs.parent_organisation.french_trade_name is 'The french trade name of this parent organisation';
comment on column ggircs.parent_organisation.english_trade_name is 'The english trade name of this parent organisation';
comment on column ggircs.parent_organisation.duns is 'The duns number for this parent organisation';
comment on column ggircs.parent_organisation.business_legal_name is 'The legal busniess name of this parent organisation';
comment on column ggircs.parent_organisation.website is 'The website for this parent organisation';

commit;
