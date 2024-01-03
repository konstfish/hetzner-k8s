resource "hcloud_server" "master_nodes" {
  count       = var.cluster_master_node_count
  name        = "${var.cluster_name}-master-${count.index}"
  image       = var.cluster_node_image
  server_type = var.cluster_master_node_type
  location    = var.hetzner_location
  user_data   = file("cloud-init.yml")
  ssh_keys    = keys(hcloud_ssh_key.default)
  network {
    network_id = hcloud_network.default.id
    ip         = cidrhost(var.cluster_network_subnet_range, count.index + 10)
  }
  public_net {
    ipv4_enabled = var.cluster_node_public_net.ipv4_enabled
    ipv6_enabled = var.cluster_node_public_net.ipv6_enabled
  }

  labels = merge(
    var.hetzner_labels,
    var.cluster_node_labels,
    {
      "cluster" = var.cluster_name
      "role"    = "master"
    }
  )
}

resource "hcloud_server" "worker_nodes" {
  count       = var.cluster_node_count
  name        = "${var.cluster_name}-worker-${count.index}"
  image       = var.cluster_node_image
  server_type = var.cluster_node_type
  location    = var.hetzner_location
  user_data   = file("cloud-init.yml")
  ssh_keys    = keys(hcloud_ssh_key.default)
  network {
    network_id = hcloud_network.default.id
    ip         = cidrhost(var.cluster_network_subnet_range, count.index + 50)
  }
  public_net {
    ipv4_enabled = var.cluster_node_public_net.ipv4_enabled
    ipv6_enabled = var.cluster_node_public_net.ipv6_enabled
  }

  labels = merge(
    var.hetzner_labels,
    var.cluster_node_labels,
    {
      "cluster" = var.cluster_name
      "role"    = "worker"
    }
  )
}