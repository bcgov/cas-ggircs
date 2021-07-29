# -*- coding: utf-8 -*-
"""
# DAGs to fetch and extract SWRS data from the ECCC website.
swrs_eccc_import_full will download and extract all zip files in the GCS bucket
swrs_eccc_import_incremental will only download and extract files that were uploaded in the first task of the DAG

Both these DAGs trigger the `transform_load_ggircs` DAG, which runs the transform/load function in the ggircs database,
thus transforming the XML files into tables
"""
import json
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
    'start_date': START_DATE,
    'is_paused_upon_creation': True
}

DAG_ID = "cas_ggircs_swrs_eccc"
SCHEDULE_INTERVAL = '0 8 * * *'

dag_incremental = DAG(DAG_ID + '_incremental', schedule_interval=SCHEDULE_INTERVAL,
                      default_args=default_args, user_defined_macros={'json': json})
dag_full = DAG(DAG_ID+'_full', schedule_interval=None,
               default_args=default_args)

eccc_upload = PythonOperator(
    python_callable=trigger_k8s_cronjob,
    task_id='cas-ggircs-eccc-upload',
    op_args=['cas-ggircs-eccc-upload', namespace],
    dag=dag_incremental
)

eccc_extract_incremental = PythonOperator(
    python_callable=trigger_k8s_cronjob,
    task_id='cas-ggircs-eccc-extract-incremental',
    op_args=['cas-ggircs-eccc-extract-incremental', namespace],
    dag=dag_incremental
)
eccc_extract_full = PythonOperator(
    python_callable=trigger_k8s_cronjob,
    task_id='cas-ggircs-eccc-extract',
    op_args=['cas-ggircs-eccc-extract', namespace],
    dag=dag_full
)


def load_ggircs(dag):
    return PythonOperator(
        python_callable=trigger_k8s_cronjob,
        task_id='load_ggircs',
        op_args=['cas-ggircs-etl-deploy', namespace],
        dag=dag)


def ggircs_read_only_user(dag):
    return PythonOperator(
        python_callable=trigger_k8s_cronjob,
        task_id='ggircs_read_only_user',
        op_args=['cas-ggircs-db-create-readonly-user', namespace],
        dag=dag)


def trigger_ciip_deploy_db_dag(dag):
    return TriggerDagRunOperator(
        task_id='trigger_ciip_deploy_db_dag',
        trigger_dag_id="cas_ciip_portal_deploy_db",
        dag=dag)


eccc_upload >> eccc_extract_incremental >> load_ggircs(dag_incremental) >> ggircs_read_only_user(
    dag_incremental) >> trigger_ciip_deploy_db_dag(dag_incremental)
eccc_extract_full >> load_ggircs(dag_full) >> ggircs_read_only_user(
    dag_full) >> trigger_ciip_deploy_db_dag(dag_full)
