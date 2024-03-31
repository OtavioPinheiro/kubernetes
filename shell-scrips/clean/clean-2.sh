#!/bin/bash

# Cores
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Deletando clusters, pods, deployments, etc.
kubectl delete svc goserver-service
kubectl delete deployments goserver
kubectl delete statefulset mysql
kind delete clusters fullcycle
if [ "$(docker ps -aq)" ]; then
    docker rm $(docker ps -aq)
else
    echo -e "${RED}Não há contêineres para remover!${NC}"
fi

if [ "docker rmi $(docker images -q)" ]; then
    docker rmi $(docker images -q)
else
    echo -e "${RED}Não há imagens para remover!${NC}"
fi

echo
echo -e "${GREEN}***** PROCESSO CONCLUÍDO *****${NC}"
