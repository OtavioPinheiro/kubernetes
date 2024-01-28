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
echo "Subindo o cluster"
kind create cluster --config=k8s/kind.yaml --name=fullcycle &&
kubectl cluster-info --context kind-fullcycle &&
echo
read -p "Qual o número do deployment deseja aplicar?" deployment
if [ -f "$(pwd)/k8s/deployment-variables-$deployment.yaml" ]; then
    echo "Subindo deployment" &&
    kubectl apply -f k8s/deployment-variables-$deployment.yaml
else
    echo "Arquivo deployment não existe! Ou não foi encontrado!"
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
echo
echo "Metrics Server" &&
kubectl apply -f k8s/metrics-server.yaml &&
echo
echo "Verificando o serviço do metrics-server"
echo
( sleep 60 ) & loading
clear
kubectl get apiservices &&
echo
kubectl get apiservices | (head -n 1; grep metrics-server)

# Obtém a resposta do comando kubectl get apiservices
response=$(kubectl get apiservices --output=wide --selector=k8s-app=metrics-server)

# Obtém o valor da coluna AVAILABLE
available=$(echo "$response" | awk '{print $3}')

# Exibe o texto OK ou NOK
echo "metrics-server disponível: $available" | grep -qiF "true" && echo -e "\e[32mOK\e[0m" || echo -e "\e[31mNOK\e[0m"
echo
( sleep 20 ) & loading
sleep 3
clear
echo "HPA" &&
kubectl apply -f k8s/hpa.yaml &&
echo "Aguardando HPA..."
( sleep 60 && echo "Processo concluído!" ) & loading
kubectl get hpa
sleep 10
clear
echo "Realizando o port-forward"
echo "Execute o comando em uma outra aba"
echo "kubectl port-forward svc/goserver-service 9000:80"
echo "Acesse localhost:9000" && xdg-open "http://localhost:9000"
# kubectl port-forward svc/goserver-service 9000:80
