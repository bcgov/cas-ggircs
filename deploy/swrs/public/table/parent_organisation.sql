-- Deploy ggircs:table_parent_organisation to pg
-- requires: schema_ggircs

begin;

create table swrs.parent_organisation (

    id                        integer primary key,
    report_id                 integer references swrs.report(id),
    organisation_id           integer references swrs.organisation(id),
    eccc_xml_file_id            integer,
    path_context              varchar(1000),
    percentage_owned          numeric,
    french_trade_name         varchar(1000),
    english_trade_name        varchar(1000),
    duns                      varchar(1000),
    business_legal_name       varchar(1000),
    website                   varchar(1000)
);

create index ggircs_parent_organisation_report_foreign_key on swrs.parent_organisation(report_id);
create index ggircs_parent_organisation_organisation_foreign_key on swrs.parent_organisation(organisation_id);

comment on table swrs.parent_organisation is 'The table housing parent organisation information';
comment on column swrs.parent_organisation.id is 'The primary key';
comment on column swrs.parent_organisation.report_id is 'A foreign key reference to swrs.report';
comment on column swrs.parent_organisation.organisation_id is 'A foreign key reference to swrs.organisation';
comment on column swrs.parent_organisation.eccc_xml_file_id is 'The foreign key reference to swrs.eccc_xml_file';
comment on column swrs.parent_organisation.path_context is 'The path context used to reach the ParentOrganisation node (VerifyTombstone or RegistrationData';
comment on column swrs.parent_organisation.percentage_owned is 'The % owned by this parent organisation';
comment on column swrs.parent_organisation.french_trade_name is 'The french trade name of this parent organisation';
comment on column swrs.parent_organisation.english_trade_name is 'The english trade name of this parent organisation';
comment on column swrs.parent_organisation.duns is 'The duns number for this parent organisation';
comment on column swrs.parent_organisation.business_legal_name is 'The legal busniess name of this parent organisation';
comment on column swrs.parent_organisation.website is 'The website for this parent organisation';

commit;
