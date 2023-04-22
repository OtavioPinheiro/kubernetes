#!/bin/bash

# Executar como root ou sudo
echo "Instalando Kind"
curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.11.1/kind-linux-amd64
chmod +x ./kind
mv ./kind /usr/bin/kind
echo
echo "Verificando a instalação do Kind"
kind version