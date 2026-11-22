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
```
