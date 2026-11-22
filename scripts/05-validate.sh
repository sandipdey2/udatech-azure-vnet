#!/bin/bash
# 05-validate.sh

set -e
RG="udacity-project-starter"

echo "=== Effective NSG rules on nic-hr ==="
az network nic list-effective-nsg -g $RG --name nic-hr -o table || true

echo ""
echo "=== VNet subnets ==="
az network vnet subnet list -g $RG --vnet-name udatech-vnet -o table

echo ""
echo "=== Bastion ==="
az network bastion list -g $RG -o table

echo ""
echo "=== Load Balancer ==="
az network lb list -g $RG -o table

echo ""
echo "=== Private DNS ==="
az network private-dns zone list -g $RG -o table

echo ""
echo "Use Azure Portal → Network Watcher for connection troubleshoot screenshots."
