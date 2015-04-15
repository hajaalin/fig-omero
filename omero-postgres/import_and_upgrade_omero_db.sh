#!/bin/bash

dump=`ls -1rt /pg_dump/*.pg_dump |tail -1`
flag="/pg_dump_import_done"
if [ ! -e $flag ]; then
	gosu postgres postgres --single -jE <<-EOSQL
		CREATE USER "omero" WITH PASSWORD '$DB_PASSWORD_OMERO' ;
	EOSQL
	echo
	gosu postgres postgres --single -jE <<-EOSQL
		CREATE DATABASE "omero" WITH OWNER "omero" ;
	EOSQL
	echo

	# Thanks to 'mhubig':
	# https://github.com/docker-library/postgres/issues/16
	echo "**IMPORTING DATABASE BACKUP**"
	gosu postgres postgres &
	PID=$!
	echo PID $PID
	sleep 2
	gosu postgres psql omero < $dump
	echo "**DATABASE BACKUP IMPORTED***"
	kill $PID
	sleep 10

	echo "host omero omero 0.0.0.0/0 md5" >> "$PGDATA"/pg_hba.conf
	touch $flag
fi


sqls=`ls -1 /psql/*.sql`
flag="/pg_omero_db_upgrade_done"
if [ ! -e $flag ]; then
        echo "**UPGRADING DATABASE**"
        gosu postgres postgres &
        PID=$!
        echo PID $PID
        sleep 2

	for sql in $sqls
	do
		echo "upgrade script:" $sql
		echo $DB_PASSWORD_OMERO >> tmp.sql
		cat $sql >> tmp.sql
		gosu postgres psql -U omero omero < tmp.sql
		rm tmp.sql
	done
	echo "**UPGRADE DONE***"
	echo

	#echo "**OPTIMIZING DATABASE***"
	#gosu postgres psql -U omero omero -c 'REINDEX DATABASE "omero_database" FORCE;'
	#gosu postgres psql -U omero omero -c 'VACUUM FULL VERBOSE ANALYZE;'
	#echo "**OPTIMIZATION DONE***"
	kill $PID
	sleep 10
	touch $flag
fi

flag="/pg_omero_root_password_set"
if [ ! -e $flag ]; then
        echo "**SETTING OMERO ROOT PASSWORD**"
        gosu postgres postgres &
        PID=$!
        echo PID $PID
        sleep 2

	PASS=`echo -n "$OMERO_ROOT_PASSWORD" |openssl md5 -binary | openssl base64`
        gosu postgres psql -U omero omero -c \
		"update password set hash = '$PASS' where experimenter_id = 0" <<-EOF
$DB_PASSWORD_OMERO
EOF
        echo "**OMERO ROOT PASSWORD SET***"
        kill $PID
        sleep 10
        touch $flag
fi

