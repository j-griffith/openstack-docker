import threading

from nova.api.openstack.placement.wsgi import init_application

app_lock = threading.Lock()

with app_lock:
    application = init_application()
