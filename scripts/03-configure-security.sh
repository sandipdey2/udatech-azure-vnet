#!/bin/bash
# 03-configure-security.sh

set -e
RG="udacity-project-starter"

echo "Configuring NSG-HR..."
az network nsg rule create -g $RG --nsg-name nsg-hr -n Allow-Bastion-RDP \
  --priority 100 --direction Inbound --access Allow --protocol Tcp \
  --source-address-prefixes 10.0.4.0/26 --destination-port-ranges 3389 \
  --destination-address-prefixes '*' --source-port-ranges '*'

az network nsg rule create -g $RG --nsg-name nsg-hr -n Deny-All-Inbound \
  --priority 200 --direction Inbound --access Deny --protocol '*' \
  --source-address-prefixes '*' --destination-port-ranges '*' \
  --destination-address-prefixes '*' --source-port-ranges '*'

echo "Configuring NSG-Sales..."
az network nsg rule create -g $RG --nsg-name nsg-sales -n Allow-Bastion-RDP \
  --priority 100 --direction Inbound --access Allow --protocol Tcp \
  --source-address-prefixes 10.0.4.0/26 --destination-port-ranges 3389 \
  --destination-address-prefixes '*' --source-port-ranges '*'

az network nsg rule create -g $RG --nsg-name nsg-sales -n Deny-All-Inbound \
  --priority 200 --direction Inbound --access Deny --protocol '*' \
  --source-address-prefixes '*' --destination-port-ranges '*' \
  --destination-address-prefixes '*' --source-port-ranges '*'

echo "Configuring NSG-DevOps..."
az network nsg rule create -g $RG --nsg-name nsg-devops -n Allow-Bastion-RDP \
  --priority 100 --direction Inbound --access Allow --protocol Tcp \
  --source-address-prefixes 10.0.4.0/26 --destination-port-ranges 3389 \
  --destination-address-prefixes '*' --source-port-ranges '*'

az network nsg rule create -g $RG --nsg-name nsg-devops -n Deny-All-Inbound \
  --priority 200 --direction Inbound --access Deny --protocol '*' \
  --source-address-prefixes '*' --destination-port-ranges '*' \
  --destination-address-prefixes '*' --source-port-ranges '*'

echo "Security rules applied."
