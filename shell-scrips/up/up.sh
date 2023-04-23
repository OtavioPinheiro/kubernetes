#!/bin/bash

# Subindo o cluster, deployment, service
echo "Subindo o cluster"
kind create cluster --config=k8s/kind.yaml --name=fullcycle &&
kubectl cluster-info --context kind-fullcycle &&
echo "Subindo deployment" &&
kubectl apply -f k8s/deployment-variables.yaml &&
echo "Subindo service" &&
kubectl apply -f k8s/service-loadBalancer.yaml &&
echo "Realizando o port-forward" &&
kubectl port-forward svc/goserver-service 9000:80 &&

echo "Serviço pronto!"