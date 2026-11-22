# UdaTech Azure Virtual Networking Project
## Complete Submission Package

This package contains everything needed to deploy, document, and validate a secure, segmented Azure virtual network for UdaTech (HR, Sales, DevOps departments).

### Contents
- `docs/` – Full documentation matching the Udacity rubric
- `scripts/` – Azure CLI scripts (updated for eastus2 + required tags)
- `diagrams/` – Architecture diagram (Mermaid)
- `README.md` – How to use this package

### Prerequisites
1. Azure subscription (Vocareum / Udacity-5)
2. Azure CLI logged in
3. Allowed regions: eastus2 or centralus
4. Required tags on resources: department=Engineering|Finance, environment=Dev|Test|Prod

### Quick Start
```bash
# 1. Deploy starter (after adding tags to template or using corrected version)
az group create --name udacity-project-starter --location eastus2
# deploy template with tags...

# 2. Then run scripts
cd scripts
chmod +x *.sh
./01-inventory-existing.sh
./02-deploy-improved-network.sh
./03-configure-security.sh
./04-deploy-bastion-lb-dns.sh
./05-validate.sh


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
```
