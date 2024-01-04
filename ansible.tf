locals {
  nodes = concat(
    [for i in range(var.cluster_master_node_count) : {
      name      = hcloud_server.master_nodes[i].name
      ip        = hcloud_server.master_nodes[i].network.*.ip[0]
      public_ip = hcloud_server.master_nodes[i].ipv6_address
    }], 
    [for i in range(var.cluster_node_count) : {
      name      = hcloud_server.worker_nodes[i].name
      ip        = hcloud_server.worker_nodes[i].network.*.ip[0]
      public_ip = hcloud_server.worker_nodes[i].ipv6_address
    }]
  )
}

resource "local_file" "ansible_inventory" {
  content = templatefile("${path.module}/ansible/inventory.tpl", {
    nodes = local.nodes,
  })
  filename = "${path.module}/ansible/inventory.yml"

  provisioner "local-exec" {
    command     = <<EOT
      echo "$SSH_PRIVATE_KEY" > ssh_key && chmod 600 ssh_key
      ansible-playbook -i inventory.yml playbook.yml
      rm ssh_key
    EOT
    working_dir = "ansible"
    environment = {
      ANSIBLE_HOST_KEY_CHECKING = "false"
      SSH_PRIVATE_KEY = nonsensitive(tls_private_key.ansible.private_key_openssh)
    }
  }
}

output "node_list" {
  value = local.nodes
}