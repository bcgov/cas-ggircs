# -*- coding: utf-8 -*-
from dag_configuration import default_dag_args
from trigger_k8s_cronjob import trigger_k8s_cronjob
from airflow.providers.standard.operators.trigger_dagrun import TriggerDagRunOperator
from airflow.decorators import dag, task
from datetime import datetime, timedelta
import os
import sys
sys.path.insert(0, os.path.abspath(os.path.dirname(__file__)))


TWO_DAYS_AGO = datetime.now() - timedelta(days=2)

namespace = os.getenv('GGIRCS_NAMESPACE')

default_args = {**default_dag_args, "start_date": TWO_DAYS_AGO}

SWRS_ECCC_DAG_NAME = "cas_ggircs_swrs_eccc"
SCHEDULE = "0 8 * * *"

GGIRCS_SWRS_ECCC_DOC = """
# DAG to fetch and extract SWRS data from the ECCC website.

The dag will
    - fetch the zip files from the ECCC website and upload them to GCS.
    - stream the XML files contained the zip files and insert them into the swrs_extract.eccc_xml_file table.
    - stream the attachment contained the zip files and insert them into the swrs_extract.eccc_attachment table.
    - trigger the transform/load jobs
"""

@dag(
    dag_id=SWRS_ECCC_DAG_NAME,
    schedule=SCHEDULE,
    default_args=default_args,
    doc_md=GGIRCS_SWRS_ECCC_DOC,
    is_paused_upon_creation=True,
)
def eccc_dag():
    @task
    def eccc_upload():
        trigger_k8s_cronjob("cas-ggircs-eccc-upload", namespace)

    @task
    def extract_zip_files():
        trigger_k8s_cronjob("cas-ggircs-eccc-extract-zips", namespace)

    @task
    def extract_xml_files():
        trigger_k8s_cronjob("cas-ggircs-eccc-extract-xml-files", namespace)

    @task
    def extract_attachments():
        trigger_k8s_cronjob("cas-ggircs-eccc-extract-attachments", namespace)

    trigger_load_db_dag = TriggerDagRunOperator(
        task_id="trigger_cas_ggircs_load_db_dag",
        trigger_dag_id="cas_ggircs_load_db",
    )

    eccc_upload() >> extract_zip_files()
    extract_zip_files() >> extract_xml_files() >> trigger_load_db_dag
    extract_zip_files() >> extract_attachments() >> trigger_load_db_dag

eccc_dag()
