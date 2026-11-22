# 2. Network Segmentation, Design & Deployment

## Design Goals
- Isolate HR, Sales, and DevOps while allowing controlled inter-department communication.
- Remove public internet exposure for management (RDP).
- Provide high availability via Load Balancer.
- Support future growth.

## Proposed Architecture

```
VNet: vnet-udatech (10.0.0.0/16) – eastus2
├── snet-hr              10.0.1.0/24     → NSG-HR     + ASG-HR
├── snet-sales           10.0.2.0/24     → NSG-Sales  + ASG-Sales
├── snet-devops          10.0.3.0/24     → NSG-DevOps + ASG-DevOps
├── AzureBastionSubnet   10.0.4.0/26     → Azure Bastion
└── snet-lb              10.0.5.0/24     → Internal Load Balancer
```

### Routing Strategy
- Default system routes for intra-VNet traffic.
- Inter-department traffic controlled by NSGs.
- No custom UDRs required for base design.

### Security Boundaries
| Source → Destination | Allowed | Purpose |
|----------------------|---------|---------|
| Bastion → any VM | RDP 3389 | Secure management |
| HR → Sales | Specific app ports | Business workflow |
| DevOps → all | Management ports | Operational access |
| Internet → any VM | Denied | No public RDP |

### Address Space Rationale
- /16 VNet for growth.
- /24 subnets (251 usable IPs).
- Dedicated /26 for Bastion (Azure requirement).

See `diagrams/architecture.mmd` for the diagram.
