FROM postgres:9.3

RUN apt-get install -y openssl

VOLUME /pg_dump

ADD import_and_upgrade_omero_db.sh /docker-entrypoint-initdb.d/


# add database upgrade script
RUN mkdir /psql
COPY psql/OMERO5.1__1/OMERO5.0__0.sql /psql/

## TODO ##
#
# Would it be better to let user place the appropriate update sql
# in a mapped directory, same way as the dump file?
# Now we are limited to one particular upgrade.
