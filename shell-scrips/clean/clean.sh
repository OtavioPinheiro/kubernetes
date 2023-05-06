#!/bin/bash

# Deletando clusters, pods, deployments, etc.
kubectl delete svc goserver-service
kubectl delete deployments goserver
kind delete clusters fullcycle
docker rm $(docker ps -a -q)
docker rmi $(docker images -q)
echo
echo "Processo concluído"