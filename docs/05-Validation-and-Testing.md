# 5. Validation & Testing

## Test Cases

| Test | Expected Result | Actual Result | Evidence |
|------|-----------------|---------------|----------|
| Bastion → vm-hr RDP | Success | Success | Bastion portal session screenshot |
| Internet → VM:3389 | Denied | Denied | Public IPs removed + Deny-All NSG rule |
| Name resolution | Resolves inside VNet | Success | `nslookup` from inside VM via Bastion |
| NSG rules enforced | Bastion allow + Deny-All | Confirmed | `az network nsg rule list` output |
| Load Balancer configured | Frontend + backend + probe + rule | Configured | LB screenshots (backend unhealthy expected – no app on port 80) |

## Network Watcher Limitation

Network Watcher could not be enabled because the lab subscription policy (`EnforceDeptEnvTags`) blocks creation of the `NetworkWatcher_eastus2` resource.

**Alternative validation performed:**
- Effective and custom NSG rules reviewed via Azure CLI
- Successful remote access through Azure Bastion
- Confirmation that public IP addresses were removed from all VMs
- Private DNS resolution verified from inside a VM

## Commands Used

```bash
# Confirm no public IPs
az vm list -g udacity-project-starter --show-details \
  --query "[].{Name:name, PublicIP:publicIps}" -o table

# Verify NSG rules
az network nsg rule list \
  --resource-group udacity-project-starter \
  --nsg-name nsg-hr \
  -o table
