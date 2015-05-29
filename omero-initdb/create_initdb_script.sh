#!/bin/bash
omero db script --password $OMERO_ROOT_PASSWORD
mv /home/omero/OMERO*sql /initdb
chmod a+r /initdb/*

