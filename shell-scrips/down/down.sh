#!/bin/bash

# Deletando pods, deployments, etc.
kubectl delete svc goserver-service
kubectl delete deployments goserver
echo
echo "Processo concluído"
