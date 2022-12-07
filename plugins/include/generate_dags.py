import os
import json
from jinja2 import Environment, FileSystemLoader


def render_dag(dag_conf, dependencies):
    env = Environment(loader=FileSystemLoader("./plugins/include"))
    
    rendered = env.get_template(f"./dag_templates/{dag_conf['dag_template']}") \
        .render(
            dag_conf=dag_conf,
            dependencies=dependencies
        )
    with open(f"./dags/{dag_conf['dag_id']}.py", 'w') as f:
        f.write(rendered)


if __name__ == '__main__':
    for conf in os.listdir('./plugins/include/dag_conf'):
        with open(os.path.join('./plugins/include/dag_conf', conf), 'r') as f:
            dag_conf = json.loads(f.read())

        for dag in dag_conf:
            task_deps = []
            for task in dag.get('tasks', []):
                task_id = task['task_id']
                depends_on = task.get('depends_on', [])
                depends_by = []
                for task_ in dag['tasks']:
                    if task['task_id'] in task_.get('depends_on', []):
                        depends_by.append(task_['task_id'])
                task_deps.append({'task_id': task_id, 'depends_on': depends_on, 'depends_by': depends_by})


            render_dag(dag, task_deps)
