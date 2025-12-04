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

2. Edit `terraform.tfvars` and add your Hetzner Cloud API token:
   ```
   hcloud_token = "your-api-token-here"
   ```

3. Initialize Terraform:
   ```bash
   terraform init
   ```

4. Review the plan:
   ```bash
   terraform plan
   ```

5. Apply the configuration:
   ```bash
   terraform apply
   ```

## Infrastructure

- **VM Type**: CX23 (2 vCPU, 4GB RAM)
- **OS**: AlmaLinux 9
- **Location**: Helsinki (hel1)
- **IPv6**: Disabled
- **Firewall Rules**:
  - Port 443: Open to all (for VLESS)
  - Port 22: Restricted to <some_ip>/32 (SSH access)

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
4. Copy `backend.tf.example` to `backend.tf` and configure:
   ```hcl
   terraform {
     cloud {
       organization = "your-organization-name"
       workspaces {
         name = "vless-server"
       }
     }
   }
   ```
