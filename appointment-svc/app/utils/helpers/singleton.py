import threading
class SingletonMeta(type):
    _instances = {}
    _lock = threading.Lock()
    def __call__(cls, *args, **kwargs):
      with cls._lock:
        if cls not in cls._instances:
            cls._instances[cls] = super(SingletonMeta, cls).__call__(*args, **kwargs)
      return cls._instances[cls]

class MultiSingletonMeta(type):
    _instances = {}
    _lock = threading.Lock()
    def __call__(cls, *args, **kwargs):
      with cls._lock:
        group_id = kwargs.get('group_id') 
        if group_id not in cls._instances:
            cls._instances[group_id] = super(SingletonMeta, cls).__call__(*args, **kwargs)
      return cls._instances[group_id]
