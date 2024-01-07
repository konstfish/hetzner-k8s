/*resource "helm_release" "tekton" {
  name             = "tekton"
  repository       = "https://cdfoundation.github.io/tekton-helm-chart/"
  chart            = "tekton-pipeline"
  namespace        = "tekton-pipelines"
  create_namespace = true

  timeout = 600

  depends_on = [
    local_file.ansible_inventory
  ]
}*/

// https://stackoverflow.com/questions/69180684/how-do-i-apply-a-crd-from-github-to-a-cluster-with-terraform
// https://tekton.dev/docs/pipelines/install/