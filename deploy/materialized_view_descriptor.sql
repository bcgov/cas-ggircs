-- Deploy ggircs:materialized_view_descriptors to pg
-- requires: table_ghgr_import

BEGIN;

create materialized view ggircs_swrs.descriptor as (
  select id as ghgr_import_id,
         depth_four_descriptors.*
  from ggircs_swrs.ghgr_import,
       xmltable(
           '(
       //Process/SubProcess/child::*[not(self::Units)]/child::*/child::*/child::*/*
   )[./text()[normalize-space(.)]/parent::* or ./@*]'
           passing xml_file
           columns
             process_idx integer path 'string(count(./ancestor::Process/preceding-sibling::Process))' not null
             ,sub_process_idx integer path 'string(count(./ancestor::SubProcess/preceding-sibling::SubProcess))' not null
             ,activity_name varchar(1000) path 'name(ancestor::Process/parent::*)' not null
             ,grandparent_idx integer path 'string(count(./parent::*/parent::*/parent::*/preceding-sibling::*))'
             ,parent_idx integer path 'string(count(./parent::*/preceding-sibling::*))'
             ,class_idx integer path 'string(count(./preceding-sibling::*))'
             ,grandparent varchar(1000) path 'name(./parent::*/parent::*)'
             ,parent varchar(1000) path 'name(./parent::*)'
             ,class varchar(1000) path 'name(.)' not null
             ,attribute varchar(1000) path 'name(./@*)' not null
             ,attr_value varchar(10000) path 'concat(./@*[1]," ",./@*[2]," ",./@*[3]," ",./@*[4]," ",./@*[5]," ",./@*[6])'
             ,node_value varchar(10000) path 'string(./text())'
         ) as depth_four_descriptors

  union all

  select id as ghgr_import_id,
         depth_three_descriptors.*
  from ggircs_swrs.ghgr_import,
       xmltable(
           '(
       //SubProcess/child::*[not(self::Units)]/child::*/*
   )[./text()[normalize-space(.)]/parent::* or ./@*]'
           passing xml_file
           columns
             process_idx integer path 'string(count(./ancestor::Process/preceding-sibling::Process))' not null
             ,sub_process_idx integer path 'string(count(./ancestor::SubProcess/preceding-sibling::SubProcess))' not null
             ,activity_name varchar(1000) path 'name(ancestor::Process/parent::*)' not null
             ,grandparent_idx integer path 'string(count(./parent::*/preceding-sibling::*))'
             ,parent_idx integer path 'string(count(*/preceding-sibling::*))'
             ,class_idx integer path 'string(count(./preceding-sibling::*))'
             ,grandparent varchar(1000) path 'name(./parent::*/parent::*)'
             ,parent varchar(1000) path 'name(./parent::*)'
             ,class varchar(1000) path 'name(.)' not null
             ,attribute varchar(1000) path 'name(./@*)' not null
             ,attr_value varchar(10000) path 'concat(./@*[1]," ",./@*[2]," ",./@*[3]," ",./@*[4]," ",./@*[5]," ",./@*[6])'
             ,node_value varchar(10000) path 'string(./text())'
         ) as depth_three_descriptors

  union all

  select id as ghgr_import_id,
         depth_one_descriptors.*
  from ggircs_swrs.ghgr_import,
       xmltable(
           '(
       //SubProcess/child::*[not(self::Units)] | //SubProcess/child::*[not(self::Units)]/*
   )[./text()[normalize-space(.)]/parent::* or ./@*]'
           passing xml_file
           columns
             process_idx integer path 'string(count(./ancestor::Process/preceding-sibling::Process))' not null
             ,sub_process_idx integer path 'string(count(./ancestor::SubProcess/preceding-sibling::SubProcess))' not null
             ,activity_name varchar(1000) path 'name(ancestor::Process/parent::*)' not null
             ,grandparent_idx integer path 'string(0)'
             ,parent_idx integer path 'string(0)'
             ,class_idx integer path 'string(count(./preceding-sibling::*))'
             ,grandparent varchar(1000) path 'name(./parent::*/parent::*/parent::*)'
             ,parent varchar(1000) path 'name(./parent::*)'
             ,class varchar(1000) path 'name(.)' not null
             ,attribute varchar(1000) path 'name(./@*)' not null
             ,attr_value varchar(10000) path 'concat(./@*[1]," ",./@*[2]," ",./@*[3]," ",./@*[4]," ",./@*[5]," ",./@*[6])'
             ,node_value varchar(10000) path 'string(./text())'
         ) as depth_one_descriptors
)
  with no data;

create unique index ggircs_descriptor_primary_key on ggircs_swrs.descriptor (ghgr_import_id, process_idx,
                                                                             sub_process_idx, activity_name,
                                                                             grandparent_idx, parent_idx, class_idx,
                                                                             parent,
                                                                             class);



comment on materialized view ggircs_swrs.descriptor is 'The materialized view containing the information on descriptors';
comment on column ggircs_swrs.descriptor.ghgr_import_id is 'A foreign key reference to ggircs_swrs.ghgr_import';
comment on column ggircs_swrs.descriptor.activity_name is 'The name of the node immediately after ReportData';
comment on column ggircs_swrs.descriptor.process_idx is 'The number of preceding Process siblings before this node';
comment on column ggircs_swrs.descriptor.sub_process_idx is 'The number of preceding SubProcess siblings before this node';
comment on column ggircs_swrs.descriptor.grandparent_idx is 'The count of grandparent node before this node';
comment on column ggircs_swrs.descriptor.parent_idx is 'The count of parent node before this node';
comment on column ggircs_swrs.descriptor.class_idx is 'The count of self node';
comment on column ggircs_swrs.descriptor.grandparent is 'The name of the grandparent node';
comment on column ggircs_swrs.descriptor.parent is 'The name of the parent node';
comment on column ggircs_swrs.descriptor.class is 'The name of the node itself';
comment on column ggircs_swrs.descriptor.attribute is 'The name of any attributes on this node';
comment on column ggircs_swrs.descriptor.attr_value is 'The value of the attributes on this node concatenated';
comment on column ggircs_swrs.descriptor.node_value is 'The text value of the node';


COMMIT;




