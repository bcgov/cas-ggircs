-- Deploy ggircs:table_organisation to pg
-- requires: schema_ggircs

begin;

create table ggircs.organisation
(
    id                        int generated always as identity primary key,
    ghgr_import_id            integer,
    swrs_organisation_id      integer,
    business_legal_name       varchar(1000),
    english_trade_name        varchar(1000),
    french_trade_name         varchar(1000),
    cra_business_number       varchar(1000),
    duns                      varchar(1000),
    website                   varchar(1000)
);

comment on table ggircs.organisation is 'the table housing all report data pertaining to the reporting organisation';
comment on column ggircs.organisation.id is 'The primary key';
comment on column ggircs.organisation.ghgr_import_id is 'The internal reference to the file imported from ghgr';
comment on column ggircs.organisation.swrs_organisation_id is 'The reporting organisation swrs id';
comment on column ggircs.organisation.business_legal_name is 'The legal business name of the reporting organisation';
comment on column ggircs.organisation.english_trade_name is 'The trade name in english';
comment on column ggircs.organisation.french_trade_name is 'The trade name in french';
comment on column ggircs.organisation.cra_business_number is 'The organisation business number according to cra';
comment on column ggircs.organisation.duns is 'The organisation duns number';
comment on column ggircs.organisation.website is 'The organisation website address';

commit;

-- refresh materialized view ggircs_swrs.organisation;
-- INSERT INTO ggircs.organisation (ghgr_import_id, swrs_organisation_id, business_legal_name, english_trade_name, french_trade_name, cra_business_number, duns, website)
-- SELECT ghgr_import_id, swrs_organisation_id, business_legal_name, english_trade_name, french_trade_name, cra_business_number, duns, website
-- FROM ggircs_swrs.organisation;
