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

output "dns_record_name" {
  value       = cloudflare_dns_record.vpn_server.name
  description = "DNS record name for the VPN server"
}

output "dns_record_content" {
  value       = cloudflare_dns_record.vpn_server.content
  description = "DNS record content (IP address)"
}

# Generate Ansible inventory file
resource "local_file" "ansible_inventory" {
  content = templatefile("${path.module}/templates/inventory.tpl", {
    server_ip     = hcloud_server.vless_server.ipv4_address
    server_name   = hcloud_server.vless_server.name
    ansible_user  = var.ansible_user
    ssh_key_path  = var.ansible_ssh_private_key_path
  })
  filename = "${path.module}/ansible_inventory.ini"
  file_permission = "0644"
}

output "ansible_inventory_path" {
  value       = local_file.ansible_inventory.filename
  description = "Path to the generated Ansible inventory file"
}
