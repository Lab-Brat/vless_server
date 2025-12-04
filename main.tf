# SSH key resource
resource "hcloud_ssh_key" "labbrat" {
  name       = "labbrat"
  public_key = var.ssh_public_key
}

resource "hcloud_firewall" "vless_firewall" {
  name = var.firewall_name

  rule {
    direction = "in"
    port      = "443"
    protocol  = "tcp"
    source_ips = [
      "0.0.0.0/0"
    ]
  }

  rule {
    direction = "in"
    port      = "22"
    protocol  = "tcp"
    source_ips = [
      "${var.ssh_allowed_ip}/32"
    ]
  }

  rule {
    direction = "out"
    protocol  = "tcp"
    destination_ips = [
      "0.0.0.0/0"
    ]
  }

  rule {
    direction = "out"
    protocol  = "udp"
    destination_ips = [
      "0.0.0.0/0"
    ]
  }
}

# Server resource
resource "hcloud_server" "vless_server" {
  name        = var.server_name
  image       = var.server_image
  server_type = var.server_type
  location    = var.server_location
  ssh_keys    = [hcloud_ssh_key.labbrat.id]
  
  # Disable IPv6
  public_net {
    ipv4_enabled = true
    ipv6_enabled = false
  }

  firewall_ids = [hcloud_firewall.vless_firewall.id]

  labels = {
    purpose = "vless-vpn"
  }
}

