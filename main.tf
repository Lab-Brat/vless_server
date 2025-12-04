resource "hcloud_ssh_key" "labbrat" {
  name       = "labbrat"
  public_key = var.ssh_public_key
}

resource "hcloud_server" "vless_server" {
  name        = var.server_name
  image       = var.server_image
  server_type = var.server_type
  location    = var.server_location
  ssh_keys    = [hcloud_ssh_key.labbrat.id]
  firewall_ids  = [hcloud_firewall.vless_firewall.id]
  
  public_net {
    ipv4_enabled = true
    ipv6_enabled = false
  }

  labels = {
    purpose = "vless-vpn"
  }
}

resource "hcloud_firewall" "vless_firewall" {
  name = var.firewall_name

  rule {
    description = "PING"
    direction   = "in"
    protocol    = "icmp"
    source_ips  = [
      "0.0.0.0/0"
    ]
  }

  rule {
    description = "SSH"
    direction   = "in"
    protocol    = "tcp"
    port        = "22"
    source_ips = var.firewall_allowed_ips
  }

}

resource "cloudflare_dns_record" "vpn_server" {
  zone_id = var.cloudflare_zone_id
  name    = var.vpn_domain_subdomain
  type    = "A"
  content = hcloud_server.vless_server.ipv4_address
  ttl     = 300
  proxied = false
}
