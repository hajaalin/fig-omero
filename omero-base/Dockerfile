FROM ubuntu:14.04

RUN sed 's/main$/main universe/' -i /etc/apt/sources.list

RUN apt-get update && \
apt-get install -yy openjdk-7-jre-headless ice35-services \
python-zeroc-ice \
postgresql-client-9.3 \
python-imaging \
python-numpy \
python-tables \
python-virtualenv \
sudo \
supervisor \
unzip \
vim \
wget

RUN useradd -m omero
RUN su - omero -c "virtualenv --system-site-packages ~/venv"
RUN su - omero -c "~/venv/bin/pip install -U yaclifw && ~/venv/bin/pip install -U omego"



