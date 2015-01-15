omero config set omero.security.trustStorePassword $OMERO_TRUSTSTORE_PASSWORD
omero config set omero.ldap.urls ldaps://$LDAP_HOST:$LDAP_PORT
. /create_truststore.sh
