FROM postgres:9.3

RUN apt-get install -y openssl

VOLUME /pg_dump

ADD import_and_upgrade_omero_db.sh /docker-entrypoint-initdb.d/

RUN mkdir /psql
ADD psql/OMERO5.0__0/OMERO4.4__0.sql /psql/
ADD psql/OMERO5.0__0/00_missing.sql /psql/
