# 5. Validation & Testing

## Test Cases

| Test | Expected Result | Tool |
|------|-----------------|------|
| Bastion → vm-hr RDP | Success | Portal Bastion |
| Internet → vm-hr:3389 | Denied | IP flow verify |
| Name resolution | Resolves | nslookup |
| Load Balancer health | Healthy | LB metrics |

## Commands
```bash
az network nic list-effective-nsg -g udacity-project-starter --name nic-hr
```

Use Azure Portal → Network Watcher for connection troubleshoot screenshots.
