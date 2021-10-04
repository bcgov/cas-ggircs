# -*- coding: utf-8 -*-
"""
# DAG to fetch and extract SWRS data from the ECCC website.

The dag will
 - fetch the zip files from the ECCC website and upload them to GCS.
 - stream the XML files contained the zip files and insert them into the swrs_extract.eccc_xml_file table.
 - stream the attachment contained the zip files and insert them into the swrs_extract.eccc_attachment table.
 - trigger the transform/load jobs

"""
from dag_configuration import default_dag_args
from trigger_k8s_cronjob import trigger_k8s_cronjob
from airflow.operators.dagrun_operator import TriggerDagRunOperator
from airflow.operators.python_operator import PythonOperator
from datetime import datetime, timedelta
from airflow import DAG
import os
import sys
sys.path.insert(0, os.path.abspath(os.path.dirname(__file__)))


START_DATE = datetime.now() - timedelta(days=2)

namespace = os.getenv('GGIRCS_NAMESPACE')

default_args = {
    **default_dag_args,
    'start_date': START_DATE
}

DAG_ID = "cas_ggircs_swrs_eccc"
SCHEDULE_INTERVAL = '0 8 * * *'

dag = DAG(
    'cas_ggircs_swrs_eccc',
    schedule_interval=SCHEDULE_INTERVAL,
    default_args=default_args,
    is_paused_upon_creation=True
)

eccc_upload = PythonOperator(
    python_callable=trigger_k8s_cronjob,
    task_id='cas-ggircs-eccc-upload',
    op_args=['cas-ggircs-eccc-upload', namespace],
    dag=dag
)

extract_zip_files = PythonOperator(
    python_callable=trigger_k8s_cronjob,
    task_id='cas-ggircs-eccc-extract-zips',
    op_args=['cas-ggircs-eccc-extract-zips', namespace],
    dag=dag
)

extract_xml_files = PythonOperator(
    python_callable=trigger_k8s_cronjob,
    task_id='cas-ggircs-eccc-extract-xml-files',
    op_args=['cas-ggircs-eccc-extract-xml-files', namespace],
    dag=dag
)

extract_attachments = PythonOperator(
    python_callable=trigger_k8s_cronjob,
    task_id='cas-ggircs-eccc-extract-attachments',
    op_args=['cas-ggircs-eccc-extract-attachments', namespace],
    dag=dag
)


trigger_load_db_dag = TriggerDagRunOperator(
    task_id='trigger_cas_ggircs_load_db_dag',
    trigger_dag_id='cas_ggircs_load_db',
    dag=dag
)


eccc_upload >> extract_zip_files
extract_zip_files >> extract_xml_files >> trigger_load_db_dag
extract_zip_files >> extract_attachments >> trigger_load_db_dag

ghg_credentials_issuer_dag = DAG(
    'ghg_credentials_issuer',
    schedule_interval=None,
    default_args=default_args,
    is_paused_upon_creation=True
)

ghg_credentials_issuer_task = PythonOperator(
    python_callable=trigger_k8s_cronjob,
    task_id='ghg_credentials_issuer',
    op_args=['cas-ggircs-ghg-credentials-issuer', namespace],
    dag=ghg_credentials_issuer_dag
)
