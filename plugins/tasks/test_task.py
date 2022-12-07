from airflow.operators.python import PythonOperator
from random import randint
from time import sleep


def log_info():
    sleep(randint(5, 10))
    print('wws')


def test_task(task_id):
    test_task = PythonOperator(
        task_id=task_id,
        python_callable=log_info
    )    
    return test_task