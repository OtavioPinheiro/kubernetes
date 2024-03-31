#!/bin/bash

loading() {
    local pid=$!
    local spin='-\|/'
    local i=0

    while kill -0 $pid 2>/dev/null; do
        i=$(( (i+1) % 4 ))
        printf "\r[%c] Aguarde..." "${spin:$i:1}"
        sleep 0.1
    done

    # printf "\rProcesso concluído\n"
}

# Subindo o cluster, deployment, service
echo "Subindo o cluster"
kind create cluster --config=k8s/kind.yaml --name=fullcycle &&
kubectl cluster-info --context kind-fullcycle &&
# read -p "Qual deployment deseja aplicar?" deployment
echo "Aplicando o Deployment"
if [ -f "$(pwd)/k8s/deployment-8.yaml" ]; then
    echo "Subindo deployment" &&
    kubectl apply -f k8s/statefulset.yaml
else
    echo "Arquivo deployment não existe"
    echo "statefulset.yaml"
    sleep 3
    exit 0
fi
echo "Aplicando o StateFulSet"
if [ -f "$(pwd)/k8s/statefulset-2.yaml" ]; then
    echo "Subindo deployment" &&
    kubectl apply -f k8s/statefulset.yaml
else
    echo "Arquivo deployment não existe"
    echo "statefulset.yaml"
    sleep 3
    exit 0
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
kubectl apply -f k8s/service-loadBalancer.yaml &&
kubectl apply -f k8s/service-mysql.yaml &&
echo
echo "Aguarde alguns instantes "
( sleep 120 ) & loading
echo "Aplicando o PVC" &&
kubectl apply -f k8s/pvc.yaml &&
# echo "Realizando o port-forward"
# echo "Execute o comando em uma outra aba"
# echo "kubectl port-forward svc/goserver-service 9000:80"
# echo "Acesse localhost:9000" && xdg-open "http://localhost:9000"
# kubectl port-forward svc/goserver-service 9000:80
echo "***** PROCESSO CONCLUÍDO *****"
