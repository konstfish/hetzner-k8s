resource "helm_release" "mongodb_operator" {
  count = var.install_mongodb_operator ? 1 : 0

  name             = "mongodb-operator"
  repository       = "https://mongodb.github.io/helm-charts"
  chart            = "community-operator"
  namespace        = "mongodb"
  create_namespace = true

  set {
    name  = "agent.name"
    value = "mongodb-agent-ubi"
  }

  depends_on = [
    local_file.ansible_inventory,
    helm_release.hcloud_csi_driver
  ]
}

// todo namespace for argo & tekton

resource "helm_release" "argocd" {
  count = var.install_argocd ? 1 : 0

  name             = "argo"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"

  timeout = 100


  depends_on = [
    local_file.ansible_inventory
  ]
}

resource "helm_release" "tekton" {
  count = var.install_tekton ? 1 : 0

  name       = "tekton"
  repository = "https://cdfoundation.github.io/tekton-helm-chart/"
  chart      = "tekton-pipeline"

  timeout = 100

  depends_on = [
    local_file.ansible_inventory
  ]
}

// https://stackoverflow.com/questions/69180684/how-do-i-apply-a-crd-from-github-to-a-cluster-with-terraform
// https://tekton.dev/docs/pipelines/install/