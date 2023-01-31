-- Deploy ggircs:swrs/transform/materialized_view/other_venting to pg

begin;

-- Other Venting Details
create materialized view swrs_transform.other_venting as (
  select row_number() over () as id, id as eccc_xml_file_id,
         other_venting_details.*
  from swrs_extract.eccc_xml_file,
       xmltable(
           '//*[contains(name(), "VentingDetails") and contains(name(), "Other") and ancestor::SubProcess[@SubprocessName = "Venting"]]'
           passing xml_file
           columns
             detail_tag varchar(1000) path 'name()',
             detail_value varchar(1000) path 'text()'
         ) as other_venting_details
  order by eccc_xml_file_id
) with no data;

create unique index ggircs_other_venting_primary_key on swrs_transform.other_venting (eccc_xml_file_id, detail_tag, detail_value);

comment on materialized view swrs_transform.other_venting is 'The materialized view containing all tags and data where the tag contains the words "Other" and "VentingDetails"';
comment on column swrs_transform.other_venting.id is 'A generated index used for keying in the ggircs schema';
comment on column swrs_transform.other_venting.eccc_xml_file_id is 'A foreign key reference to swrs_extract.eccc_xml_file';
comment on column swrs_transform.other_venting.detail_tag is 'The name of the tag parsed by this materialized view. Describes the source of the "other venting".';
comment on column swrs_transform.other_venting.detail_value is 'The value of the tag parsed by this materialized view. Describes how the "other venting" was vented.';

commit;
