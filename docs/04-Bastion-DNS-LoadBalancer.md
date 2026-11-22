# 4. Bastion, DNS, and Load Balancer

## Azure Bastion
- Subnet: `AzureBastionSubnet` (10.0.4.0/26)
- Public IP: Standard, static
- Connect via portal → Bastion (no public IP needed on VMs)

## DNS / Name Resolution
```bash
az network private-dns zone create -g udacity-project-starter -n udatech.local
az network private-dns link vnet create -g udacity-project-starter \
  --zone-name udatech.local --name link-udatech \
  --virtual-network udatech-vnet --registration-enabled true
```

## Load Balancer
Internal Standard Load Balancer with backend pool, health probe, and load balancing rule.

## Screenshots to Capture
- Bastion resource + successful connection
- Private DNS zone + VNet link
- Load Balancer backend pool + rule
