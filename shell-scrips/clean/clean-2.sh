#!/bin/bash

# Deletando clusters, pods, deployments, etc.
kubectl delete svc goserver-service
kubectl delete deployments goserver
kubectl delete statefulset mysql
kind delete clusters fullcycle
docker rm $(docker ps -a -q)
docker rmi $(docker images -q)
echo
echo "***** PROCESSO CONCLUÍDO *****"
