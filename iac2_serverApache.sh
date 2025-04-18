#!/bin/bash

#####################################################################
# Script para criação de diretórios, grupos e usuários.             #
# Escrevendo log para auditoria em /var/log/createAppApache.log     #
# 17/04/2025 - Em atendimento de projeto Curso DIO Linux            #
#              Santander OpenAcademy                                #
#####################################################################
(
# string com data
registro=$(date +\%d\%m\%Y)
# criando função para hora
timestamp(){
date +"%T"
}
echo "[Atualizando servidor - Aplicação web Apache] em: $registro"
timestamp
apt-get update
apt-get upgrade -y
echo "Instalando apache"
apt-get install apache2 -y
echo "Iniciando o serviço do Apache"
service apache2 start
echo "Instalando unZIP"
apt-get install unzip -y
cd /tmp

echo "Verificando se há requisitos para download da aplicação"
dpkg -s wget &> /dev/null
if [ $? -ne 0 ]
  then
    echo "WGET não instalado"
    apt-get install wget
  else
    echo "wget instalado"
fi

echo "Baixando arquivos da aplicação"
wget https://github.com/denilsonbonatti/linux-site-dio/archive/refs/heads/main.zip
echo "Descompactando arquivos"
unzip main.zip
cd linux-site-dio-main
echo "Copiando arquivos para raiz do Apache"
cp -R * /var/www/html
echo "Processo finalizado"
) 2>&1 | tee -a /var/log/createAppApache.log
