Image for a webserver container that will connect to OMERO.web.

nginx.conf is created by "omero web config nginx | sed 's/0.0.0.0/omeroweb/'", where 
"omeroweb" is the service name used in ../fig.yml. See http://serverfault.com/questions/577370/how-can-i-use-environment-variables-in-nginx-conf.

This is not very elegant, because now we have to manually extract the config file to
be able to build the image. Waiting for a better idea.



