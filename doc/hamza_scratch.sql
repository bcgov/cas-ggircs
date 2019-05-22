copy ggircs_swrs.ghgr_import
from '/Users/hamzajaved/Development/GGIRCS/dev/ggircs/data/select_t_REPORT_ID__t_XML_FILE__t_WHEN_C.csv'
with (format csv);


REFRESH MATERIALIZED VIEW ggircs_swrs.report;
REFRESH MATERIALIZED VIEW ggircs_swrs.final_report;
REFRESH MATERIALIZED VIEW ggircs_swrs.facility;
REFRESH MATERIALIZED VIEW ggircs_swrs.organisation;
REFRESH MATERIALIZED VIEW ggircs_swrs.activity;
REFRESH MATERIALIZED VIEW ggircs_swrs.unit;
REFRESH MATERIALIZED VIEW ggircs_swrs.fuel;
REFRESH MATERIALIZED VIEW ggircs_swrs.emission;
REFRESH MATERIALIZED VIEW ggircs_swrs.descriptor;
REFRESH MATERIALIZED VIEW ggircs_swrs.address;
REFRESH MATERIALIZED VIEW ggircs_swrs.identifier;
REFRESH MATERIALIZED VIEW ggircs_swrs.naics;
REFRESH MATERIALIZED VIEW ggircs_swrs.contact;
REFRESH MATERIALIZED VIEW ggircs_swrs.permit;
REFRESH MATERIALIZED VIEW ggircs_swrs.parent_organisation;


create table report_table as
  select * from report;

create unique index ggircs_activity_table_primary_key on
  ggircs_swrs.activity_table (ghgr_import_id, process_idx, sub_process_idx, activity_name);

ALTER TABLE ggircs_swrs.activity_table
      ADD CONSTRAINT activity_pk
      PRIMARY KEY (ghgr_import_id, process_idx, sub_process_idx, activity_name);

alter table

create table activity_table as
  select * from activity;


create table descriptor_table as
  select * from descriptor;

create unique index ggircs_descriptor_table_primary_key
  on ggircs_swrs.descriptor_table (ghgr_import_id, context, process_idx,
                                   sub_process_idx,
                                   grandparent_idx, parent_idx, class_idx,
                                   parent,
                                   class);

ALTER TABLE ggircs_swrs.descriptor_table
      ADD CONSTRAINT descriptor_table_pk
      PRIMARY KEY (ghgr_import_id, context, process_idx,
                                   sub_process_idx,
                                   grandparent_idx, parent_idx, class_idx,
                                   parent,
                                   class);

Alter table ggircs_swrs.activity_table
add constraint descriptor_fk
  foreign key (ghgr_import_id, activity_name, process_idx, sub_process_idx)
  references descriptor_table (ghgr_import_id, context, process_idx, sub_process_idx)
