Build Docker images for OMERO

These images are intended for deployment with Docker Compose. The build script
creates a compose.yml file for development use. Deployment scripts are maintained
in a separate repository (https://github.com/hajaalin/fig-omero-deploy).

Prerequisites:
- install Docker (https://docs.docker.com/)
- install Docker Compose (https://docs.docker.com/compose/install/)
<del>- install ejson (https://github.com/Shopify/ejson)</del>
<del>- install jq (http://stedolan.github.io/jq/)</del>

Configuration:
<del>- copy private key corresponding to secrets.ejson to /opt/ejson/keys</del>
<del>- copy database dump to directory mapped in fig.yml</del>

Launch:
./run.sh

TODO:
- use data-only containers
- database replication
- testing
- understanding OMERO.FS:n

TODO DEPLOYMENT
- mounting current data on new VM





