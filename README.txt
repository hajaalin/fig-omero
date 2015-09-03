Deploy OMERO with Docker and Fig.

Prerequisites:
- install Docker (https://docs.docker.com/)
- install Docker Compose (https://docs.docker.com/compose/install/)
- install ejson (https://github.com/Shopify/ejson)
- install jq (http://stedolan.github.io/jq/)

Configuration:
- copy private key corresponding to secrets.ejson to /opt/ejson/keys
- copy database dump to directory mapped in fig.yml

Launch:
./run.sh

TODO:
- use data-only containers
- database replication
- testing
- understanding OMERO.FS:n

TODO DEPLOYMENT
- mounting current data on new VM





