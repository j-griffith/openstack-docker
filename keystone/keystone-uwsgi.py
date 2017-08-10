import threading

from keystone.server.wsgi import initialize_public_application

app_lock = threading.Lock()

with app_lock:
    application = initialize_public_application()
