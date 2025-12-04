[vless_servers]
${server_name} ansible_host=${server_ip} ansible_user=${ansible_user} ansible_ssh_private_key_file=${ssh_key_path}

[vless_servers:vars]
ansible_python_interpreter=/usr/bin/python3

