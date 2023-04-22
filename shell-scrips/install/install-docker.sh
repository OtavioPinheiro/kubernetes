#!/bin/bash

# Executar como root ou sudo
echo "-- INSTALANDO O DOCKER --"
echo

echo "Removendo versões antigas do Docker...";
sudo apt-get remove docker docker-engine docker.io containerd runc;
echo

echo "Atualizando os repositórios...";
sudo apt-get update;
echo

echo "Instalando os pacotes necessários para a comunicação com o repositório Docker através do protocolo HTTPS";
sudo apt-get install ca-certificates curl gnupg lsb-release;
echo

echo "chave GPG";
sudo mkdir -m 0755 -p /etc/apt/keyrings;
sudo curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg;
echo

echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null;

sudo apt update;
echo

echo "Instalando o Docker";
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin;
echo

echo "Adicionando o usuário no grupo";
usermod -aG docker $USER