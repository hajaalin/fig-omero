. make_env.sh
ansible-playbook build_images.yml -e dev=true
docker-compose -f compose/compose-DEV.yml rm
docker-compose -f compose/compose-DEV.yml up
