#!/bin/bash

cmd="omero config set omero.web.server_list '[[\""
cmd="${cmd}$OMERO_PORT_4064_TCP_ADDR\", 4064, \"omero\"]]'"

echo $cmd > /tmp/cmd.sh
. /tmp/cmd.sh


