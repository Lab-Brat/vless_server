# Ansible Playbooks for 3x-ui Deployment

This directory contains Ansible playbooks and roles for deploying 3x-ui on AlmaLinux 10 servers.

## Structure

```
ansible/
├── site.yml              # Main playbook - deploys everything
├── test-connection.yml   # Connection test playbook
├── roles/
│   └── 3x-ui/           # Main role for 3x-ui deployment
│       ├── tasks/
│       │   ├── main.yml        # Includes other task files
│       │   ├── system-base.yml # System configuration tasks
│       │   ├── docker.yml      # Docker installation tasks
│       │   └── 3x-ui.yml       # 3x-ui application deployment
│       ├── templates/
│       │   └── docker-compose.yml.j2  # Docker Compose template
│       ├── defaults/
│       ├── handlers/
│       └── ...
└── README.md            # This file
```

## Prerequisites

Before running the playbooks, install the required Ansible collections:

```bash
ansible-galaxy collection install -r requirements.yml
```

## Usage

### Deploy Everything

To deploy the complete application (system updates, basic packages, Docker, and 3x-ui):

```bash
ansible-playbook -i ../ansible_inventory.ini site.yml
```

### Deploy Specific Components

Use tags to deploy only specific parts:

**System configuration only:**
```bash
ansible-playbook -i ../ansible_inventory.ini site.yml --tags system-base
```

**Docker only:**
```bash
ansible-playbook -i ../ansible_inventory.ini site.yml --tags docker
```

**Skip Docker:**
```bash
ansible-playbook -i ../ansible_inventory.ini site.yml --skip-tags docker
```

**Skip system configuration:**
```bash
ansible-playbook -i ../ansible_inventory.ini site.yml --skip-tags system-base
```

**Deploy only 3x-ui application:**
```bash
ansible-playbook -i ../ansible_inventory.ini site.yml --tags 3x-ui
```

**Skip 3x-ui deployment:**
```bash
ansible-playbook -i ../ansible_inventory.ini site.yml --skip-tags 3x-ui
```

**Verify installation:**
```bash
ansible-playbook -i ../ansible_inventory.ini site.yml --tags verify
```

## Available Tags

- `system-base` / `system` / `base` - System updates and basic packages
- `docker` - Docker installation and configuration
- `3x-ui` / `app` - 3x-ui application deployment
- `verify` - Verification tasks
- `always` - Tasks that always run (system-base and docker)

## Role: 3x-ui

The main role that handles all deployment tasks.

### Task Files

- **system-base.yml** - Handles system updates and installation of basic packages
- **docker.yml** - Handles Docker installation, configuration, and verification
- **3x-ui.yml** - Handles 3x-ui application deployment using Docker Compose

### Variables

- `docker_users`: List of users to add to the docker group (optional)
- `xui_base_path`: Base path for 3x-ui installation (default: `/opt/3x-ui`)
- `xui_hostname`: Optional hostname for the container (default: empty)
- `xui_vmess_aead_forced`: Force VMESS AEAD (default: `"false"`)
- `xui_enable_fail2ban`: Enable fail2ban (default: `"true"`)

**Example:**
```yaml
- hosts: servers
  roles:
    - role: 3x-ui
      vars:
        docker_users: ['ansible', 'deploy']
        xui_base_path: /opt/3x-ui
        xui_hostname: "myserver.example.com"
        xui_vmess_aead_forced: "false"
        xui_enable_fail2ban: "true"
```
