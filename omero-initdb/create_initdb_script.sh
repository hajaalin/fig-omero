#!/bin/bash
omero db script --password $OMERO_ROOT_PASSWORD
mv OMERO*sql /initdb
chmod a+r /initdb/*

echo omero-initdb: create_initdb_script.sh exiting...
