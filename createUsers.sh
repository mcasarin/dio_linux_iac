#!/bin/bash

################################################################
# Script para criação de diretórios, grupos e usuários.        #
# Escrevendo log para auditoria em /var/log/createUser.log     #
# 27/03/2025 - Em atendimento de projeto Curso DIO Linux       #
#              Santander OpenAcademy                           #
################################################################
(
# string com data
registro=$(date +\%d\%m\%Y)
# criando função para hora
timestamp(){
date +"%T"
}
echo "Data: $registro"
timestamp
echo "[Criando diretórios]"
mkdir /publico
mkdir /adm
mkdir /ven
mkdir /sec

timestamp
echo "[Criando grupos de usuários]"
groupadd GRP_ADM
groupadd GRP_VEN
groupadd GRP_SEC

timestamp
echo "[Criando usuários e atribuindo grupos]"
# usuários grupo Administrativo
useradd carlos -m -s /bin/bash -p $(openssl passwd -crypt Senha123) -G GRP_ADM 
useradd maria -m -s /bin/bash -p $(openssl passwd -crypt Senha123) -G GRP_ADM
useradd joao -m -s /bin/bash -p $(openssl passwd -crypt Senha123) -G GRP_ADM
# usuários grupo Vendas
useradd debora -m -s /bin/bash -p $(openssl passwd -crypt Senha123) -G GRP_VEN
useradd sebastiana -m -s /bin/bash -p $(openssl passwd -crypt Senha123) -G GRP_VEN
useradd roberto -m -s /bin/bash -p $(openssl passwd -crypt Senha123) -G GRP_VEN
# usuários grupo Segurança
useradd josefina -m -s /bin/bash -p $(openssl passwd -crypt Senha123) -G GRP_SEC
useradd amanda -m -s /bin/bash -p $(openssl passwd -crypt Senha123) -G GRP_SEC
useradd rogerio -m -s /bin/bash -p $(openssl passwd -crypt Senha123) -G GRP_SEC

timestamp
echo "[Definindo permissões de diretórios]"
# Definindo donos e grupos
chown root:GRP_ADM /adm
chown root:GRP_VEN /ven
chown root:GRP_SEC /sec
# Definindo permissões por diretórios
chmod 777 /publico
chmod 770 /adm
chmod 770 /ven
chmod 770 /sec
echo "Finalizado em: $(timestamp)"
) 2>&1 | tee -a /var/log/createUser.log
