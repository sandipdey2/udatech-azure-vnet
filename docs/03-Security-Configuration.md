# 3. Security Controls (NSG, ASG, Private Endpoints)

## Network Security Groups

### NSG-HR (example)
| Priority | Name | Direction | Access | Source | Destination | Port |
|----------|------|-----------|--------|--------|-------------|------|
| 100 | Allow-Bastion-RDP | Inbound | Allow | 10.0.4.0/26 | * | 3389 |
| 200 | Deny-All-Inbound | Inbound | Deny | * | * | * |

Similar rules for NSG-Sales and NSG-DevOps.

## Application Security Groups
- `asg-hr`
- `asg-sales`
- `asg-devops`

## Public IP Removal
After Bastion is validated:
```bash
az network nic ip-config update \
  --resource-group udacity-project-starter \
  --nic-name nic-hr \
  --name ipconfig1 \
  --remove publicIpAddress
```

## Protection Goals
- Least privilege
- No direct public RDP
- Management only via Bastion
- Maintainable rules via ASGs
