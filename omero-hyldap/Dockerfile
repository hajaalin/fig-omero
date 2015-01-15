FROM hajaalin/omero

USER root

RUN apt-get install -y ldap-utils 

ENV OMERO_TRUSTSTORE /home/omero/truststore.jks

ADD set_config_hyldap.sh /set_config_hyldap.sh
ADD create_truststore.sh /create_truststore.sh
ADD edit_system_truststore.sh /edit_system_truststore.sh
ADD hyldapConfig.xml /home/omero/hyldapConfig.xml
ADD hyldap.jar /opt/omero/lib/server/extensions.jar
ADD SSLPoke.java /SSLPoke.java

RUN chown omero:omero /*.sh 

USER omero
RUN omero config set omero.security.trustStore $OMERO_TRUSTSTORE \
&& omero config set omero.ldap.config true \
&& omero config set omero.ldap.urls ldaps://ldap-internal.it.helsinki.fi:636 \
&& omero config set omero.ldap.base dc=helsinki,dc=fi \
&& omero config set omero.ldap.user_mapping 'omeName=uid,firstName=givenName,lastName=sn,email=uid' \
&& omero config set omero.ldap.new_user_group ':bean:hyldapbean' \
&& omero config set omero.ldap.sync_on_login false \
&& echo "hyldap.config=/home/omero/hyldapConfig.xml" >> /opt/omero/etc/omero.properties

