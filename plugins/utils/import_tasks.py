import os
from importlib import import_module


def import_task(path):
    mod, func = os.path.splitext(path)
    return getattr(import_module(mod), func[1:])