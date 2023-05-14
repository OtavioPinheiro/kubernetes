#!/bin/bash

# Subindo o cluster, deployment, service
read -p "Qual deployment deseja aplicar?" deployment
if [ -f "$(pwd)/k8s/deployment-variables-$deployment.yaml" ]; then
    echo "Subindo deployment" &&
    kubectl apply -f k8s/deployment-variables-$deployment.yaml
else
    echo "Arquivo deployment não existe"
    echo "deployment-variables-$deployment.yaml"
    echo "Aplicando o arquivo deployment padrão ..."
    kubectl apply -f k8s/deployment.yaml
fi
echo
echo "Aplicando ConfigMap" &&
kubectl apply -f k8s/configmap-env.yaml &&
kubectl apply -f k8s/configmap-family.yaml &&
echo
echo "Aplicando Secrets" &&
kubectl apply -f k8s/secret.yaml &&
echo
echo "Subindo service" &&
kubectl apply -f k8s/service-clusterIP.yaml &&
echo
echo "Aguarde alguns instantes ..."
sleep 120
echo "Realizando o port-forward"
kubectl port-forward svc/goserver-service 9000:80
