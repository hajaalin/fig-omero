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
		gosu postgres psql omero < $sql
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

