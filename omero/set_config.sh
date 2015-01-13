#!/bin/bash
omero config set omero.db.host $DB_PORT_5432_TCP_ADDR
omero config set omero.db.pass $DB_PASSWORD_OMERO
omero config set omero.security.trustStorePassword $OMERO_TRUSTSTORE_PASSWORD

