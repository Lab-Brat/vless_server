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

variable "ssh_allowed_ip" {
  description = "IP address allowed to access SSH (port 22)"
  type        = string
  default     = "0.0.0.0/0"
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
