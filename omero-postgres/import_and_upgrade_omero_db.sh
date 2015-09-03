#!/bin/bash

flag="/database_initialized"
if [ ! -e $flag ]; then
	#
	# Create a new database and user for OMERO.
	# This is needed both for a fresh database and before importing a database dump.
	#
	gosu postgres postgres --single -jE <<-EOSQL
		CREATE USER "omero" WITH PASSWORD '$DB_PASSWORD_OMERO' ;
	EOSQL

	gosu postgres postgres --single -jE <<-EOSQL
		CREATE DATABASE "omero" WITH OWNER "omero" ;
	EOSQL

	#
	# Check if there is a database dump file, if yes, import it and upgrade and optimize.
	#
	dump=`find /pg_dump -maxdepth 1 -name "*.pg_dump"|sort|tail -1`
	if [ -r "$dump" ]; then
		# Thanks to 'mhubig':
		# https://github.com/docker-library/postgres/issues/16
		echo "**IMPORTING DATABASE BACKUP**"
		echo dump $dump
		gosu postgres postgres &
		PID=$!
		sleep 2
		gosu postgres psql omero < $dump
		echo "**DATABASE BACKUP IMPORTED***"
		kill $PID
		sleep 10


		echo "**UPGRADING DATABASE**"
		gosu postgres postgres &
		PID=$!
		sleep 2

		sqls=`find /psql -maxdepth 1 -name "*.sql"`
		for sql in $sqls
		do
			echo "upgrade script:" $sql
			PGPASSWORD=$DB_PASSWORD_OMERO gosu postgres psql -U omero omero < $sql
		done
		echo "**UPGRADE DONE***"
		echo

		echo "**OPTIMIZING DATABASE***"
		gosu postgres psql -U omero omero -c 'REINDEX DATABASE "omero" FORCE;'
		gosu postgres psql -U omero omero -c 'VACUUM FULL VERBOSE ANALYZE;'
		echo "**OPTIMIZATION DONE***"
		kill $PID
		sleep 10


		echo "**SETTING OMERO ROOT PASSWORD**"
		gosu postgres postgres &
		PID=$!
		sleep 2

		PASS=`echo -n "$OMERO_ROOT_PASSWORD" |openssl md5 -binary | openssl base64`
		gosu postgres psql -U omero omero -c \
			"update password set hash = '$PASS' where experimenter_id = 0" <<-EOF
$DB_PASSWORD_OMERO
EOF
		echo "**OMERO ROOT PASSWORD SET***"
		kill $PID
		sleep 10


	#
	# No database dump file provided, create a fresh OMERO database.
	#
	else
		sql=`find /initdb -maxdepth 1 -name "*.sql"|head -1`
		ls -lart /initdb
		echo "**CREATING NEW OMERO DATABASE**"
		gosu postgres postgres &
		PID=$!
		sleep 2
		echo "initdb script:" $sql
		PGPASSWORD=$DB_PASSWORD_OMERO gosu postgres psql -U omero omero < $sql
		echo "**OMERO DATABASE CREATED***"
		kill $PID
		sleep 10
	fi


	#
	# Allow access to the database.
	#
	echo "host omero omero 0.0.0.0/0 md5" >> "$PGDATA"/pg_hba.conf


	touch $flag

fi

echo omero-postgres: import_and_upgrade_omero_db.sh exiting...
