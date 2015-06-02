#!/bin/bash
omero db script --password $OMERO_ROOT_PASSWORD
mv OMERO*sql /initdb
chmod a+r /initdb/*

