#!/bin/bash
# 04-deploy-bastion-lb-dns.sh
# Updated for eastus2 + tags

set -e
RG="udacity-project-starter"
VNET="udatech-vnet"
LOCATION="eastus2"
TAGS="department=Engineering environment=Dev"

echo "Creating Public IP for Bastion..."
az network public-ip create \
  --resource-group $RG \
  --name pip-bastion \
  --sku Standard \
  --location $LOCATION \
  --allocation-method Static \
  --tags $TAGS

echo "Creating Azure Bastion..."
az network bastion create \
  --resource-group $RG \
  --name bastion-udatech \
  --public-ip-address pip-bastion \
  --vnet-name $VNET \
  --location $LOCATION \
  --tags $TAGS

echo "Creating Private DNS Zone..."
az network private-dns zone create \
  --resource-group $RG \
  --name udatech.local \
  --tags $TAGS

az network private-dns link vnet create \
  --resource-group $RG \
  --zone-name udatech.local \
  --name link-udatech \
  --virtual-network $VNET \
  --registration-enabled true

echo "Creating Internal Load Balancer..."
az network lb create \
  --resource-group $RG \
  --name lb-udatech \
  --sku Standard \
  --location $LOCATION \
  --vnet-name $VNET \
  --subnet snet-lb \
  --frontend-ip-name fe-lb \
  --backend-pool-name be-pool \
  --tags $TAGS

az network lb probe create \
  --resource-group $RG \
  --lb-name lb-udatech \
  --name probe-tcp80 \
  --protocol Tcp \
  --port 80

az network lb rule create \
  --resource-group $RG \
  --lb-name lb-udatech \
  --name rule-http \
  --protocol Tcp \
  --frontend-port 80 \
  --backend-port 80 \
  --frontend-ip-name fe-lb \
  --backend-pool-name be-pool \
  --probe-name probe-tcp80

echo "Bastion, DNS, and Load Balancer deployed."
