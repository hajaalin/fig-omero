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
- use data-only containers
- database replication
- testing
- understanding OMERO.FS:n

TODO DEPLOYMENT
- new VM from CSC, Ubuntu 14
- mounting current data on new VM





