# VLESS Server Deployment

This repository contains Terraform configuration to deploy a VLESS VPN server on Hetzner Cloud.

## Prerequisites

1. Hetzner Cloud account with API token
2. Terraform installed (>= 1.0)
3. SSH key pair at `~/.ssh/<key_name>`
4. Set `HCLOUD_TOKEN` environment variable:
   ```bash
   export HCLOUD_TOKEN="your-hetzner-cloud-api-token-here"
   ```

## Setup

1. Copy the example variables file:
   ```bash
   cp terraform.tfvars.example terraform.tfvars
   ```

2. Edit `terraform.tfvars` and configure:
   - Your SSH public key
   - Server configuration (name, type, image, location)
   - Firewall configuration (allowed SSH IP address)

3. Set the `HCLOUD_TOKEN` environment variable:
   ```bash
   export HCLOUD_TOKEN="your-hetzner-cloud-api-token-here"
   ```

4. Initialize Terraform:
   ```bash
   terraform init
   ```

5. Review the plan and apply:
   ```bash
   terraform plan -var="hcloud_token=$HCLOUD_TOKEN"
   sterraform apply -var="hcloud_token=$HCLOUD_TOKEN"
   ```

## Infrastructure

- **VM Type**: CX23 (2 vCPU, 4GB RAM) - configurable via `server_type`
- **OS**: AlmaLinux 10 - configurable via `server_image`
- **Location**: Helsinki (hel1) - configurable via `server_location`
- **IPv6**: Disabled
- **Firewall Rules**:
  - Port 443: Open to all (for VLESS)
  - Port 22: Restricted to IP specified in `ssh_allowed_ip` variable

## Outputs

After deployment, Terraform will output:
- `server_ip`: The IPv4 address of your VLESS server
- `server_id`: The Hetzner Cloud server ID

## Terraform State Storage

By default, Terraform stores state locally. For production use, consider using remote state storage:

### Terraform Cloud

Terraform Cloud offers free tier with GitHub integration:

1. Sign up at https://app.terraform.io
2. Create an organization and workspace
3. Connect your GitHub repository
4. Create a `backend.tf` file and configure:
   ```hcl
   terraform {
     cloud {
       hostname     = "app.terraform.io"
       organization = "your-organization-name"
       workspaces {
         name = "vless-server"
       }
     }
   }
   ```
5. Run `terraform login` locally to authenticate in app.terraform.io