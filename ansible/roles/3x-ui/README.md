# 3x-ui Role

This Ansible role deploys 3x-ui on AlmaLinux/RHEL systems.

## Requirements

- AlmaLinux 8, 9, or 10
- Ansible 2.9 or higher
- Root or sudo access

## Role Variables

- `docker_users`: List of users to add to the docker group (optional)
- `xui_base_path`: Base path for 3x-ui installation (default: `/opt/3x-ui`)
- `xui_hostname`: Optional hostname for the container (default: empty)
- `xui_vmess_aead_forced`: Force VMESS AEAD (default: `"false"`)
- `xui_enable_fail2ban`: Enable fail2ban (default: `"true"`)

## Task Files

- `system-base.yml` - System updates and basic package installation
- `docker.yml` - Docker installation and configuration
- `3x-ui.yml` - 3x-ui application deployment

## Usage

### Deploy everything

```yaml
- hosts: servers
  roles:
    - role: 3x-ui
```

### Deploy only system-base

```bash
ansible-playbook -i inventory site.yml --tags system-base
```

### Deploy only Docker

```bash
ansible-playbook -i inventory site.yml --tags docker
```

### Deploy only 3x-ui application

```bash
ansible-playbook -i inventory site.yml --tags 3x-ui
```

### Example with custom variables

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

## Tags

- `system-base` / `system` / `base` - System configuration tasks
- `docker` - Docker installation tasks
- `3x-ui` / `app` - 3x-ui application deployment
- `verify` - Verification tasks
- `always` - Tasks that always run (system-base and docker)

