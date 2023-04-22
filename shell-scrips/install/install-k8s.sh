#!/bin/bash

# Executar como root ou sudo
echo "Atualizando o índice e instalando os pacotes necessários"
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl
echo
echo "Chave de assinatura pública do Google Cloud"
sudo curl -fsSLo /etc/apt/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
echo
echo "Instalando Kubernetes"
echo "deb [signed-by=/etc/apt/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl
echo
echo "Verificando a instalação"
kubectl version