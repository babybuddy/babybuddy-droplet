import netifaces

from .base import *

# Digital Ocean Droplet settings
# See babybuddy.settings.base for additional settings information.

SECRET_KEY = "@SECRET_KEY@"

# Set allowed hosts using the drop IP addresses.

def ip_addresses():
    ip_list = []
    for interface in netifaces.interfaces():
        addrs = netifaces.ifaddresses(interface)
        for x in (netifaces.AF_INET, netifaces.AF_INET6):
            if x in addrs:
                ip_list.append(addrs[x][0]['addr'])
    return ip_list

ALLOWED_HOSTS = ip_addresses()

# Database
# https://docs.djangoproject.com/en/5.0/ref/settings/#databases

DATABASES = {
    "default": {
        "ENGINE": "django.db.backends.sqlite3",
        "NAME": os.path.join(BASE_DIR, "../data/db.sqlite3"),
    }
}

# Media files
# https://docs.djangoproject.com/en/5.0/topics/files/

MEDIA_ROOT = os.path.join(BASE_DIR, "../data/media")

# Security
# After setting up SSL, uncomment the settings below for enhanced security of
# application cookies.
#
# See https://docs.djangoproject.com/en/5.0/topics/http/sessions/#settings
# See https://docs.djangoproject.com/en/5.0/ref/csrf/#settings

# SESSION_COOKIE_SECURE = True
# CSRF_COOKIE_SECURE = True
