Deploy OMERO with Docker and Fig.

Prerequisites:
- install Docker (https://docs.docker.com/)
- install Fig (http://www.fig.sh/install.html)
- install ejson (https://github.com/Shopify/ejson)
- install jq (http://stedolan.github.io/jq/)

Configuration:
- copy private key corresponding to secrets.ejson to /opt/ejson/keys
- copy database dump to directory mapped in fig.yml

Launch:
source make_env.sh
fig up


TODO:
- Dockerfile for OMERO
- Dockerfile for OMERO.web
- database replication





