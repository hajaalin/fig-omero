#!/bin/bash
. /set_config_web.sh

cd /opt/omero/lib/python/omeroweb
export PYTHONPATH=.:/opt/omero/lib/python
exec python manage.py runfcgi workdir=./ method=prefork host=0.0.0.0 port=4080 \
pidfile=/opt/omero/var/django.pid daemonize=false \
maxchildren=5 minspare=1 maxspare=5 maxrequests=400
