terraform {
  required_providers {
    //cloudflare = {
    //  source  = "cloudflare/cloudflare"
    //  version = "~> 4.0"
    //}

    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "~> 1.44"
    }
  }
}

provider "hcloud" {
  token = var.hcloud_token
}

//provider "cloudflare" {
//  api_token = var.cloudflare_api_token
//}

provider "kubernetes" {
  config_path    = "ansible/artifacts/admin.conf"
  config_context = var.cluster_name
}

provider "helm" {
  kubernetes {
    config_path = "ansible/artifacts/admin.conf"
  }
}