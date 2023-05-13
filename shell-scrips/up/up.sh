#!/bin/bash

# Subindo o cluster, deployment, service
echo "Subindo o cluster"
kind create cluster --config=k8s/kind.yaml --name=fullcycle &&
kubectl cluster-info --context kind-fullcycle &&
echo
echo "Subindo deployment" &&
kubectl apply -f k8s/deployment-variables-3.yaml &&
echo
echo "Subindo ConfigMap" &&
kubectl apply -f k8s/configmap-env.yaml &&
echo
echo "Subindo service" &&
kubectl apply -f k8s/service-clusterIP.yaml &&
echo
echo "Aguarde alguns instantes ..."
sleep 120
echo "Realizando o port-forward"
kubectl port-forward svc/goserver-service 9000:80
