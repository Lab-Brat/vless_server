variable "ssh_public_key" {
  description = "SSH public key content"
  type        = string
  sensitive   = false
}

variable "server_name" {
  description = "Name of the VLESS server"
  type        = string
  default     = "vless-server"
}

variable "server_type" {
  description = "Hetzner Cloud server type"
  type        = string
  default     = "cx23"
}

variable "server_image" {
  description = "OS image for the server"
  type        = string
  default     = "alma-10"
}

variable "server_location" {
  description = "Hetzner Cloud datacenter location"
  type        = string
  default     = "hel1"
}

variable "firewall_allowed_ips" {
  description = "List of IP address ranges that are allowed through firewall"
}

variable "firewall_name" {
  description = "Name of the firewall resource"
  type        = string
  default     = "vless-firewall"
}

variable "hcloud_token" {
  description = "Hetzner Cloud API token with write access"
  sensitive = true
}

variable "cloudflare_api_token" {
  description = "Cloudflare API token with DNS edit permissions"
  type        = string
  sensitive   = true
}

variable "cloudflare_zone_id" {
  description = "Cloudflare zone ID for the domain"
  type        = string
}

variable "vpn_domain_subdomain" {
  description = "Subdomain name for the VPN server (e.g., 'vpn' for vpn.example.com)"
  type        = string
}
