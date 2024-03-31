#!/bin/bash

# Deletando pods, deployments, etc.
kubectl delete svc goserver-service
kubectl delete deployments goserver
kubectl delete statefulset mysql
echo
echo "Processo concluído"
