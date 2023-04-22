#!/bin/bash

# Executar como root ou sudo
echo "Instalando MiniKube"
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
install minikube-linux-amd64 /usr/local/bin/minikube
echo
echo "Verificando a instalação do MiniKube"
minikube version