#!/bin/bash

# Executar como root ou sudo
echo "Atualizando o índice e instalando os pacotes necessários"
sudo apt-get update
sudo apt-get install -y ca-certificates curl
echo
echo "Chave de assinatura pública do Google Cloud"
sudo curl -fsSLo /etc/apt/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
echo
echo "Instalando Kubernetes"
echo "deb [signed-by=/etc/apt/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubectl=1.24.12-00
echo
echo "Verificando a instalação"
kubectl version