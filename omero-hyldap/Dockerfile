FROM hajaalin/omero

ENV OMERO_TRUSTSTORE /home/omero/truststore.jks

USER root
RUN su -c "/opt/omero/bin/omero config set omero.trustStore $OMERO_TRUSTSTORE" omero

ADD set_config_hyldap.sh /set_config_hyldap.sh
ADD create_truststore.sh /create_truststore.sh

RUN chown omero:omero /set_config_hyldap.sh
RUN chown omero:omero /create_truststore.sh

USER omero


