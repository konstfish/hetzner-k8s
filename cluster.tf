provider "kubernetes" {
  config_path    = "ansible/artifacts/admin.conf"
  config_context = var.cluster_name
}

provider "helm" {
  kubernetes {
    config_path = "ansible/artifacts/admin.conf"
  }
}