# UdaTech Network Project – Documentation

| File | Rubric Section |
|------|----------------|
| 01-Assessment-Existing-Environment.md | Existing environment assessment |
| 02-Network-Design.md | Segmentation design |
| 03-Security-Configuration.md | NSGs, ASGs |
| 04-Bastion-DNS-LoadBalancer.md | Bastion, DNS, LB |
| 05-Validation-and-Testing.md | Validation |
| 06-Final-Review.md | Final review |

Diagram: `../diagrams/architecture.mmd`
Scripts: `../scripts/`

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

## Commands Used

```bash
az network nsg rule list -g udacity-project-starter --nsg-name nsg-hr -o table
nc -zv -w 5 20.186.93.240 3389
az network private-dns link vnet list -g udacity-project-starter --zone-name udatech.local -o table
az network lb address-pool show -g udacity-project-starter --lb-name lb-udatech --name be-pool

## Cross-VNet DNS (verified)
Test performed via Run Command on VM `vm-dns-vnet2` (private IP 10.1.1.5) in `udatech-vnet2`.  
`nslookup vm-hr.udatech.local` returned `10.0.1.4`.

## Load Balancer Health & High Availability
- NSG rule `Allow-LB-Probe` (priority 150, source AzureLoadBalancer, port 80) placed before Deny-All.
- Both VMs (10.0.3.4 and 10.0.3.5) are in `be-pool`.
- Frontend request to 10.0.5.4 returned HTTP 200.
- Failover test: after deallocating one backend, the frontend still returned HTTP 200, confirming the remaining instance served traffic.
