Image for a webserver container that will connect to OMERO.web.

nginx.conf is created by "omero web config nginx" and manual editing:
- /opt/omero -> /
- http.include /opt/omero/etc/mime.types
- http.server.location[/static].alias /opt/omero/lib/python/omeroweb/static
- http.server.location[/].fastcgi_pass omeroweb:4080
- http.server.location[/].fastcgi_param HTTPS $https

"omeroweb" is the service name used in ../fig.yml. See http://serverfault.com/questions/577370/how-can-i-use-environment-variables-in-nginx-conf.

This is not very elegant, because now we have to manually extract the config file to
be able to build the image. Waiting for a better idea.



