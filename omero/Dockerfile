FROM hajaalin/omero-base

ENV BRANCH OMERO-5.0-latest

RUN mkdir -p /data/OMERO \
&& chown omero:omero /data/OMERO \
&& ln -s /data/OMERO /OMERO \
&& cd /tmp \
&& /home/omero/venv/bin/omego download server --branch=$BRANCH --labels ICE=3.5 \
&& rm OMERO.server*zip \
&& chown -R omero:omero OMERO.server* \
&& mv OMERO.server* /opt/ \
&& ln -s /opt/OMERO.server* /opt/omero \
&& mkdir -p /opt/omero/var \
&& mkdir -p /opt/omero/var/master \
&& mkdir -p /opt/omero/var/registry \
&& chown -R omero:omero /opt/omero/var \
&& mkdir -p /data/logs \
&& chown -R omero:omero /data/logs \
&& ln -s /data/logs /opt/omero/var/log \
&& su -c "/opt/omero/bin/omero config set omero.db.poolsize 50" omero

VOLUME /data/OMERO /data/logs

ENV OMERO_HOME /opt/omero
ENV PATH $OMERO_HOME/bin:$PATH

ADD set_secrets.sh /set_secrets.sh

USER omero

ENTRYPOINT ["icegridnode", \
"--nochdir", \
"--Ice.Config=/opt/omero/etc/internal.cfg,/opt/omero/etc/master.cfg", \
"--deploy /opt/omero/etc/grid/default.xml"]


