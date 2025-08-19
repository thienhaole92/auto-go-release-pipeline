# 🚀 auto-go-release-pipeline

`auto-go-release-pipeline` is an Ansible deployment system for `auto-go-app`.

## 🔧 How to Run the Deployment

### 1️⃣ Set Up Environment Variables

## 🔑 Set Up Environment Variables

These must be configured in your repository settings (**Settings → Secrets → Actions**):

```env
# ===================================
# SSH Connection Settings
# ===================================
ANSIBLE_SSH_USER=<deployer>
ANSIBLE_SSH_KEY=<base64-encoded-private-key>
ANSIBLE_VAULT_PASSWORD=<my_super_secret>

# ===================================
# Deployment Target
# ===================================
DEVELOPMENT_HOST=your.server.ip.or.hostname
```

### 2️⃣ Deployment Workflow

The pipeline automatically triggers when:

1. A merge request is merged to `main` in [auto-go](https://github.com/thienhaole92/auto-go)
2. The workflow performs these steps:
   - Sets up Ansible environment
   - Configures SSH access
   - Runs deployment playbook
   - Cleans up sensitive files
