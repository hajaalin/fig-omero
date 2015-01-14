FROM hajaalin/omero

USER root

ADD set_config_web.sh /set_config_web.sh
ADD start_omero_web.sh /start_omero_web.sh
RUN chown omero:omero /*.sh

RUN mkdir /nginx
RUN chown omero:omero /nginx

USER omero
RUN omero web syncmedia
RUN omero web config nginx > /nginx/nginx.conf

VOLUME /opt/omero/lib/python/omeroweb/static
VOLUME /opt/omero/etc
VOLUME /nginx

ENTRYPOINT /start_omero_web.sh
