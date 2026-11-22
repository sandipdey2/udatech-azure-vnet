# UdaTech Azure Virtual Network Design & Deployment

Azure Virtual Network implementation for UdaTech with departmental segmentation (HR, Sales, DevOps), least-privilege security, secure management access, private name resolution, and high availability.

## Overview

This project designs, deploys, and validates a production-ready Azure network for UdaTech. It starts from a minimal starter environment, identifies security and scalability gaps, then implements a segmented architecture with Network Security Groups, Application Security Groups, Azure Bastion, Private DNS, an internal Load Balancer, and a Private Endpoint.

**Resource Group:** `udacity-project-starter`  
**Region:** East US 2  
**VNet:** `udatech-vnet` (`10.0.0.0/16`)

## Architecture

```
VNet: udatech-vnet (10.0.0.0/16)
├── hr-subnet              10.0.1.0/24   → nsg-hr     + asg-hr
├── sales-subnet           10.0.2.0/24   → nsg-sales  + asg-sales
├── devops-subnet          10.0.3.0/24   → nsg-devops + asg-devops
├── AzureBastionSubnet     10.0.4.0/26   → Azure Bastion
└── snet-lb                10.0.5.0/24   → Internal Load Balancer

Second VNet: udatech-vnet2 (10.1.0.0/16)
└── test-subnet            10.1.1.0/24   (used for cross-VNet DNS validation)
```

## Key Components

| Component | Purpose |
|-----------|---------|
| **Virtual Network + Subnets** | Departmental isolation with room for growth |
| **NSGs** | Least-privilege rules (Bastion RDP allow + Deny-All) |
| **ASGs** | Logical grouping of departmental VMs |
| **Azure Bastion** | Secure RDP without public IPs on VMs |
| **Private DNS Zone** | `udatech.local` linked to both VNets |
| **Internal Load Balancer** | High availability with two healthy backends |
| **Private Endpoint** | Secure blob storage access (`pe-blob`) |
| **Public IP Removal** | Eliminated direct internet exposure |

## Security Model

- Management access **only** via Azure Bastion (source `10.0.4.0/26`, port 3389)
- All other inbound traffic denied by NSG
- Public IP addresses removed from all VMs
- Private endpoint for storage (connection Approved)
- Application Security Groups for maintainable policy
- Private DNS for internal name resolution (including cross-VNet)

## Validation Evidence

- Bastion RDP session successful (allowed path)
- External connection to port 3389 timed out (denied path)
- Private DNS resolution verified from both VNets
- Private endpoint `pe-blob` deployed and Approved
- Load Balancer backend pool contains two Running VMs
- Network Watcher blocked by lab policy; alternative CLI + in-VM evidence used

## Repository Structure

```
.
├── docs/                          # Written documentation
├── scripts/                       # Deployment and validation scripts
├── diagrams/                      # Architecture diagram
├── screenshot/                    # Portal and CLI evidence
└── UdaTech_Network_Project_Written_Submission.docx
```

## License

Educational project for Udacity Azure networking coursework.
