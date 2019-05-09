-- Deploy ggircs:materialized_view_descriptors to pg
-- requires: table_ghgr_import

BEGIN;

create materialized view ggircs_swrs.descriptor as (
  with x as (
    select ghgr_import.id       as ghgr_import_id,
           ghgr_import.xml_file as source_xml
    from ggircs_swrs.ghgr_import
    order by ghgr_import_id desc
  )
  select ghgr_import_id,
         depth_four_descriptors.*
  from x,
       xmltable(
           '(
       //Process/SubProcess/child::*[not(self::Units)]/child::*/child::*/child::*/*
   )[./text()[normalize-space(.)]/parent::* or ./@*]'
           passing source_xml
           columns
             context varchar(1000) path 'name(ancestor::Process/parent::*)' not null
             ,process_idx integer path 'string(count(./ancestor::Process/preceding-sibling::Process))' not null
             ,sub_process_idx integer path 'string(count(./ancestor::SubProcess/preceding-sibling::SubProcess))' not null
             ,grandparent_idx integer path 'string(count(./parent::*/parent::*/parent::*/preceding-sibling::*))'
             ,parent_idx integer path 'string(count(./parent::*/preceding-sibling::*))'
             ,class_idx integer path 'string(count(./preceding-sibling::*))'
             ,grandparent varchar(1000) path 'name(./parent::*/parent::*)'
             ,parent varchar(1000) path 'name(./parent::*)'
             ,class varchar(1000) path 'name(.)' not null
             ,attribute varchar(1000) path 'name(./@*)' not null
             ,attr_value varchar(1000) path 'concat(./@*[1]," ",./@*[2]," ",./@*[3]," ",./@*[4]," ",./@*[5]," ",./@*[6])'
             ,node_value varchar(1000) path 'string(./text())'
         ) as depth_four_descriptors

  union all

  select ghgr_import_id,
         depth_three_descriptors.*
  from x,
       xmltable(
           '(
       //SubProcess/child::*[not(self::Units)]/child::*/*
   )[./text()[normalize-space(.)]/parent::* or ./@*]'
           passing source_xml
           columns
             context varchar(1000) path 'name(ancestor::Process/parent::*)' not null ,
             process_idx integer path 'string(count(./ancestor::Process/preceding-sibling::Process))' not null
             ,sub_process_idx integer path 'string(count(./ancestor::SubProcess/preceding-sibling::SubProcess))' not null
             ,grandparent_idx integer path 'string(count(./parent::*/preceding-sibling::*))'
             ,parent_idx integer path 'string(count(*/preceding-sibling::*))'
             ,class_idx integer path 'string(count(./preceding-sibling::*))'
             ,grandparent varchar(1000) path 'name(./parent::*/parent::*)'
             ,parent varchar(1000) path 'name(./parent::*)'
             ,class varchar(1000) path 'name(.)' not null
             ,attribute varchar(1000) path 'name(./@*)' not null
             ,attr_value varchar(1000) path 'concat(./@*[1]," ",./@*[2]," ",./@*[3]," ",./@*[4]," ",./@*[5]," ",./@*[6])'
             ,node_value varchar(1000) path 'string(./text())'
         ) as depth_three_descriptors

  union all

  select ghgr_import_id,
         depth_one_descriptors.*
  from x,
       xmltable(
           '(
       //SubProcess/child::*[not(self::Units)] | //SubProcess/child::*[not(self::Units)]/*
   )[./text()[normalize-space(.)]/parent::* or ./@*]'
           passing source_xml
           columns
             context varchar(1000) path 'name(ancestor::Process/parent::*)' not null
             ,process_idx integer path 'string(count(./ancestor::Process/preceding-sibling::Process))' not null
             ,sub_process_idx integer path 'string(count(./ancestor::SubProcess/preceding-sibling::SubProcess))' not null
             ,grandparent_idx integer path 'string(0)'
             ,parent_idx integer path 'string(0)'
             ,class_idx integer path 'string(count(./preceding-sibling::*))'
             ,grandparent varchar(1000) path 'name(./parent::*/parent::*/parent::*)'
             ,parent varchar(1000) path 'name(./parent::*)'
             ,class varchar(1000) path 'name(.)' not null
             ,attribute varchar(1000) path 'name(./@*)' not null
             ,attr_value varchar(1000) path 'concat(./@*[1]," ",./@*[2]," ",./@*[3]," ",./@*[4]," ",./@*[5]," ",./@*[6])'
             ,node_value varchar(1000) path 'string(./text())'
         ) as depth_one_descriptors
)
  with no data;

create unique index ggircs_descriptor_primary_key on ggircs_swrs.descriptor (ghgr_import_id, context, process_idx,
                                                                             sub_process_idx,
                                                                             grandparent_idx, parent_idx, class_idx,
                                                                             parent,
                                                                             class);



COMMIT;




