# 5. Validation & Testing

## Test Cases

| Test | Expected Result | Actual Result | Evidence |
|------|-----------------|---------------|----------|
| Bastion → vm-hr RDP | Success | Success | Bastion portal session |
| Internet → VM:3389 | Denied | Denied (timeout) | `nc` timeout + NSG Deny-All rule |
| Name resolution (same VNet) | Resolves | Success | nslookup from vm-hr |
| Name resolution (cross-VNet) | Resolves | Success | nslookup from VM in udatech-vnet2 |
| NSG rules enforced | Bastion allow + Deny-All | Confirmed | `az network nsg rule list` |
| Load Balancer | 2 healthy backends | 2 VMs in pool, Running | Backend pool screenshot |
| Private Endpoint | Deployed + Approved | Success | pe-blob overview + DNS config |

## Network Watcher Limitation

Network Watcher could not be enabled because the lab subscription policy (`EnforceDeptEnvTags`) blocks creation of the `NetworkWatcher_eastus2` resource.

**Alternative validation performed:**
- Effective and custom NSG rules reviewed via Azure CLI
- Successful remote access through Azure Bastion (allowed path)
- External connection attempt to port 3389 timed out (denied path)
- Public IP addresses removed from all VMs
- Private DNS resolution verified from inside a VM and from a second VNet
- Private endpoint deployed and approved
<<<<<<< HEAD

## Cross-VNet DNS

Private DNS zone `udatech.local` is linked to both `udatech-vnet` and `udatech-vnet2`.  
Resolution tested from a VM in `udatech-vnet2`:

```
nslookup vm-hr.udatech.local → 10.0.1.4
nslookup vm-sales.udatech.local → 10.0.2.4
nslookup vm-devops.udatech.local → 10.0.3.4
```

## Private Endpoint

Private endpoint `pe-blob` created in `hr-subnet` for storage account `udatechstg68434`.  
Connection status: **Approved**.  
Private DNS configuration shows A record `10.0.1.5` for `udatechstg68434.blob.core.windows.net`.

## Load Balancer

Backend pool `be-pool` contains two instances:
- vm-devops (10.0.3.4)
- vm-devops2 (10.0.3.5)

Both VMs are Running. IIS was installed so the TCP/80 health probe succeeds.

## Traffic Path Evidence

| Path | Source | Destination | Port | Result |
|------|--------|-------------|------|--------|
| Allowed | Bastion subnet 10.0.4.0/26 | vm-hr | 3389 | Success |
| Denied | External Internet | vm-hr | 3389 | Timeout |
=======
>>>>>>> 81b7b943c3dcd64134dc3d42ef2504c4345a774d

## Cross-VNet DNS

<<<<<<< HEAD
```bash
az network nsg rule list -g udacity-project-starter --nsg-name nsg-hr -o table
nc -zv -w 5 20.186.93.240 3389
az network private-dns link vnet list -g udacity-project-starter --zone-name udatech.local -o table
az network lb address-pool show -g udacity-project-starter --lb-name lb-udatech --name be-pool
```
=======
Private DNS zone `udatech.local` is linked to both `udatech-vnet` and `udatech-vnet2`.  
Resolution tested from a VM in `udatech-vnet2`:

nslookup vm-hr.udatech.local → 10.0.1.4

nslookup vm-sales.udatech.local → 10.0.2.4

nslookup vm-devops.udatech.local → 10.0.3.4
>>>>>>> 81b7b943c3dcd64134dc3d42ef2504c4345a774d
