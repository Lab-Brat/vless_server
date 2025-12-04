output "server_ip" {
  value       = hcloud_server.vless_server.ipv4_address
  description = "IPv4 address of the VLESS server"
}

output "server_id" {
  value       = hcloud_server.vless_server.id
  description = "ID of the VLESS server"
}

output "server_name" {
  value       = hcloud_server.vless_server.name
  description = "Name of the VLESS server"
}

