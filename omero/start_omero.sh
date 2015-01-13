#!/bin/bash
. /set_config.sh

# loop to test db connection before starting OMERO server
i="0"
imax="60"
nodb=1
while [ "$nodb" -gt "0" ]
do
    psql -h $DB_PORT_5432_TCP_ADDR -U omero omero -c "select * from dbpatch" <<-EOF
$DB_PASSWORD_OMERO
EOF
    nodb=$?
    echo nodb $nodb
    sleep 10

    i=$[$i+1]
    if [ $i -gt $imax ]; then
        echo "Failed to connect to db at $DB_PORT_5432_TCP_ADDR" 
	exit 1
    fi
done

cd /opt/omero
icegridnode \
--nochdir \
--Ice.Config=/opt/omero/etc/internal.cfg,/opt/omero/etc/master.cfg \
--deploy /opt/omero/etc/grid/default.xml

