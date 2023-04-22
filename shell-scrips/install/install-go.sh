#!/bin/bash

# Para esse script funcionar é necessário ter o Go baixado
# É necessário também executar esse script como root ou sudo
# e.g. sudo ./install-go.sh
echo "INSTALANDO GO..."

echo "Removendo versões anteriores do Go e Instalando a nova versão"
rm -rf /usr/local/go && tar -C /usr/local -xzf /home/otavio/Downloads/go1.20.2.linux-amd64.tar.gz

echo "Adicionando nas variáveis de ambiente"
export PATH=$PATH:/usr/local/go/bin

echo "Atualizando o terminal"
source $HOME/.profile

echo "Concluindo e verificando a instalação do Go"
go version