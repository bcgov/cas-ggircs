# -*- coding: utf-8 -*-
"""
# DAG to fetch and extract SWRS data from the ECCC website.

The dag will

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


load_ggircs = PythonOperator(
    python_callable=trigger_k8s_cronjob,
    task_id='load_ggircs',
    op_args=['cas-ggircs-etl-deploy', namespace],
    dag=dag
)


ggircs_read_only_user = PythonOperator(
    python_callable=trigger_k8s_cronjob,
    task_id='ggircs_read_only_user',
    op_args=['cas-ggircs-db-create-readonly-user', namespace],
    dag=dag
)


trigger_ciip_deploy_db_dag = TriggerDagRunOperator(
    task_id='trigger_ciip_deploy_db_dag',
    trigger_dag_id="cas_ciip_portal_deploy_db",
    dag=dag
)


eccc_upload >> extract_zip_files
extract_zip_files >> extract_xml_files >> load_ggircs
extract_zip_files >> extract_attachments >> load_ggircs

load_ggircs >> ggircs_read_only_user >> trigger_ciip_deploy_db_dag
