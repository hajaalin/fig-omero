FROM hajaalin/omero

USER root

ADD set_config_web.sh /set_config_web.sh
ADD start_omero_web.sh /start_omero_web.sh
RUN chown omero:omero /*.sh

ENTRYPOINT /start_omero_web.sh

USER omero

