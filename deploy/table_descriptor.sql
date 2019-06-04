-- Deploy ggircs:table_descriptor to pg
-- requires: schema_ggircs

begin;

create table ggircs.descriptor (

    id                        int generated always as identity primary key,
    ghgr_import_id            integer,
    process_idx               integer,
    sub_process_idx           integer,
    grandparent_idx           integer,
    parent_idx                integer,
    class_idx                 integer,
    activity_name             varchar(1000),
    grandparent               varchar(1000),
    parent                    varchar(1000),
    class                     varchar(1000),
    attribute                 varchar(1000),
    attr_value                varchar(10000),
    node_value                varchar(10000)
);

comment on table ggircs.descriptor is 'The table containing the information on descriptors';
comment on column ggircs.descriptor.id is 'The primary key';
comment on column ggircs.descriptor.ghgr_import_id is 'A foreign key reference to ggircs.ghgr_import';
comment on column ggircs.descriptor.activity_name is 'The name of the node immediately after ReportData';
comment on column ggircs.descriptor.grandparent is 'The name of the grandparent node';
comment on column ggircs.descriptor.parent is 'The name of the parent node';
comment on column ggircs.descriptor.class is 'The name of the node itself';
comment on column ggircs.descriptor.attribute is 'The name of any attributes on this node';
comment on column ggircs.descriptor.attr_value is 'The value of the attributes on this node concatenated';
comment on column ggircs.descriptor.node_value is 'The text value of the node';

commit;
