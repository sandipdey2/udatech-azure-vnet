# 1. Assessment of Existing Environment

## Inventory (after deploying template-project-starter.json)

| Resource Type | Name | Configuration | Notes |
|---------------|------|---------------|-------|
| Resource Group | udacity-project-starter | eastus2 | Starter RG |
| Virtual Network | udatech-vnet | 10.0.0.0/16 | Single VNet for all departments |
| Subnet | hr-subnet | 10.0.1.0/24 | |
| Subnet | sales-subnet | 10.0.2.0/24 | |
| Subnet | devops-subnet | 10.0.3.0/24 | |
| Network Security Group | udatech-nsg | Allow-All-Inbound (priority 100, * → *) | Shared by all VMs |
| Public IP | pip-hr, pip-sales, pip-devops | Static, Standard | One per VM |
| Network Interface | nic-hr, nic-sales, nic-devops | Associated with public IP + open NSG | |
| Virtual Machine | vm-hr, vm-sales, vm-devops | Windows Server 2019, Standard_B2s, azureadmin | All exposed publicly |

## Identified Gaps & Issues

### Connectivity
- All departments share one VNet with no route tables or isolation controls.
- No DNS private zone configured.
- No load balancer.

### Security
- **Critical**: NSG allows all inbound traffic from any source.
- All VMs have public IP addresses.
- No Azure Bastion.
- No Application Security Groups (ASGs).
- No private endpoints.
- No least-privilege segmentation.

### Scalability & High Availability
- Single VM per department.
- No load balancer backend pools.
- No availability zones / scale sets.

## Summary of Missing Components
- Network segmentation / proper NSGs & ASGs
- Azure Bastion
- Load Balancer(s)
- Private DNS zone
- Diagnostic logging / Network Watcher validation
