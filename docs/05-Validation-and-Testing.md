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

## Cross-VNet DNS

Private DNS zone `udatech.local` is linked to both `udatech-vnet` and `udatech-vnet2`.  
Resolution tested from a VM in `udatech-vnet2`:
