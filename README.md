# NARUTO : Networked Agent Replication Utility Tool Orchestrator

## Python Dependencies

This project uses [uv](https://github.com/astral-sh/uv) for Python dependency management.

### Installing dependencies

```bash
# Install uv if you haven't already
curl -LsSf https://astral.sh/uv/install.sh | sh

# Install project dependencies
uv sync

# Install pre-commit hooks
uv run pre-commit install
```

## Ansible Setup

You can also use Ansible to automate the Kubernetes setup:

### Prerequisites

Before running Ansible, ensure SSH access is configured:

0. **Install required packages**:
```bash
# For SSH password authentication
sudo apt-get install openssh-server sshpass

# Start SSH service if not running
sudo systemctl start ssh
sudo systemctl enable ssh
```

1. **SSH Key Setup**: Generate SSH keys if you haven't already:
```bash
ssh-keygen -t rsa -b 4096
```

2. **Copy SSH keys to target nodes**:
```bash
ssh-copy-id user@your-master-ip
ssh-copy-id user@your-worker-ip
```

3. **Test SSH connection**:
```bash
ssh user@your-master-ip
```

### Setup Steps

1. Install Ansible dependencies:
```bash
# Install system dependencies
sudo apt-get install python3-pip sshpass

# Install Ansible collections
ansible-galaxy collection install -r ansible/requirements.yml
```

2. Create an inventory file (e.g., `inventory.yml`):
```yaml
all:
  hosts:
    master:
      ansible_host: your-master-ip
      node_type: master
    worker1:
      ansible_host: your-worker-ip
      node_type: worker
```

2. Create a playbook (e.g., `setup-k8s.yml`):
```yaml
---
- hosts: all
  become: true
  roles:
    - setup-k8s
```

3. Run the playbook:
```bash
ansible-playbook -i inventory.yml setup-k8s.yml
```

If you setup in single node (local machine), you can use this command:

```bash
# Uses local connection - no SSH required
ansible-playbook -i inventory_standalone.yml setup-k8s.yml --ask-become-pass
```

Note: The `inventory_standalone.yml` uses `ansible_connection: local` which runs commands directly on the local machine without SSH.
