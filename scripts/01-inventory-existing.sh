#!/bin/bash
# 01-inventory-existing.sh
set -e
RG="udacity-project-starter"

echo "=== Resource Group ==="
az group show --name $RG --query "{name:name, location:location}" -o table

echo ""
echo "=== Virtual Networks ==="
az network vnet list -g $RG -o table

echo ""
echo "=== Subnets ==="
az network vnet subnet list -g $RG --vnet-name udatech-vnet -o table

echo ""
echo "=== Network Security Groups ==="
az network nsg list -g $RG -o table

echo ""
echo "=== Virtual Machines ==="
az vm list -g $RG --show-details -o table

echo ""
echo "=== Public IPs ==="
az network public-ip list -g $RG -o table
