FROM apache/airflow:slim-2.4.3-python3.8

ENV AIRFLOW_HOME=/opt/airflow

COPY requirements.txt .
COPY airflow.cfg .

RUN pip install --upgrade pip
RUN pip install -r /opt/airflow/requirements.txt
