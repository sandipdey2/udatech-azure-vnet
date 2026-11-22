#!/bin/bash
# 02-deploy-improved-network.sh
# Updated for eastus2 + policy tags

set -e
RG="udacity-project-starter"
VNET="udatech-vnet"
LOCATION="eastus2"
TAGS="department=Engineering environment=Dev"

echo "Creating Bastion subnet..."
az network vnet subnet create \
  --resource-group $RG \
  --vnet-name $VNET \
  --name AzureBastionSubnet \
  --address-prefixes 10.0.4.0/26

echo "Creating LB subnet..."
az network vnet subnet create \
  --resource-group $RG \
  --vnet-name $VNET \
  --name snet-lb \
  --address-prefixes 10.0.5.0/24 || true

echo "Creating Application Security Groups..."
az network asg create -g $RG -n asg-hr -l $LOCATION --tags $TAGS
az network asg create -g $RG -n asg-sales -l $LOCATION --tags $TAGS
az network asg create -g $RG -n asg-devops -l $LOCATION --tags $TAGS

echo "Creating dedicated NSGs..."
az network nsg create -g $RG -n nsg-hr -l $LOCATION --tags $TAGS
az network nsg create -g $RG -n nsg-sales -l $LOCATION --tags $TAGS
az network nsg create -g $RG -n nsg-devops -l $LOCATION --tags $TAGS

echo "Associating NSGs with subnets..."
az network vnet subnet update -g $RG --vnet-name $VNET -n hr-subnet --nsg nsg-hr
az network vnet subnet update -g $RG --vnet-name $VNET -n sales-subnet --nsg nsg-sales
az network vnet subnet update -g $RG --vnet-name $VNET -n devops-subnet --nsg nsg-devops

echo "Associating ASGs with NICs..."
az network nic ip-config update -g $RG --nic-name nic-hr --name ipconfig1 --asgs asg-hr
az network nic ip-config update -g $RG --nic-name nic-sales --name ipconfig1 --asgs asg-sales
az network nic ip-config update -g $RG --nic-name nic-devops --name ipconfig1 --asgs asg-devops

echo "Improved network base deployed."
