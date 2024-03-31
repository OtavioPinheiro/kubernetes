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

    printf "\rProcesso concluído\n"
}

# Subindo o cluster, deployment, service
read -p "Qual deployment deseja aplicar?" deployment
if [ -f "$(pwd)/k8s/deployment-$deployment.yaml" ]; then
    echo "Subindo deployment" &&
    kubectl apply -f k8s/deployment-$deployment.yaml
else
    echo "Arquivo deployment não existe"
    echo "deployment-$deployment.yaml"
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
( sleep 120 ) & loading
echo "Realizando o port-forward"
echo "Execute o comando em uma outra aba"
echo "kubectl port-forward svc/goserver-service 9000:80"
echo "Acesse localhost:9000" && xdg-open "http://localhost:9000"
# kubectl port-forward svc/goserver-service 9000:80
