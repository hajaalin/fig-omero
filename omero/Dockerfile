FROM hajaalin/omero-base

ENV BRANCH OMERO-5.1-latest

RUN cd /tmp \
&& /home/omero/venv/bin/omego download server --branch=$BRANCH --labels ICE=3.5

RUN cd /tmp \
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
&& mkdir -p /data/OMERO \
&& chown omero:omero /data/OMERO \
&& ln -s /data/OMERO /OMERO \
&& su -c "/opt/omero/bin/omero config set omero.db.poolsize 50" omero \
&& su -c "/opt/omero/bin/omero admin jvmcfg || echo jvmcfg not available" omero \
&& mkdir -p /tmp/omero \
&& chown -R omero:omero /tmp/omero

ENV OMERO_TEMPDIR /tmp/omero
ENV OMERO_HOME /opt/omero
ENV PATH $OMERO_HOME/bin:$PATH

ADD set_config.sh /set_config.sh
ADD start_omero.sh /start_omero.sh
RUN chown omero:omero /*.sh

VOLUME /data/OMERO /data/logs

USER omero

WORKDIR /opt/omero

#ENTRYPOINT ["cd /opt/omero&& icegridnode", \
#"--nochdir", \
#"--Ice.Config=/opt/omero/etc/internal.cfg,/opt/omero/etc/master.cfg", \
#"--deploy /opt/omero/etc/grid/default.xml"]

ENTRYPOINT /start_omero.sh

