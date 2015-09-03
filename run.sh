#!/bin/sh
. make_env.sh
ansible-playbook build_images.yml 
docker-compose -f compose/compose-DEV.yml rm
docker-compose -f compose/compose-DEV.yml up

