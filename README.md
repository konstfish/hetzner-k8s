# hetzner-k8s
Create a Kubernetes Cluster on Hetzner Cloud using 3 inputs (Hetzner API key, Cloudflare API key & Account ID)
Needs about ~30 minutes to complete

## Variables
Defaults are pretty sensible, see [./variables.tf](./variables.tf) & [./terraform.tfvars](./terraform.tfvars)

## Kubespray
[Kubespray](https://github.com/kubernetes-sigs/kubespray) is used to set up the Nodes in [./ansible.tf](ansible.tf). If you need more configuration see [./ansible/group_vars](./ansible/group_vars/)

## Ingress
Done using https://github.com/STRRL/cloudflare-tunnel-ingress-controller, I didn't want to pay for Hetzner's load balancers

## Usage
```
export TF_VAR_hcloud_token="xxx"
export TF_VAR_cloudflare_api_token="xxx"
export TF_VAR_cloudflare_acount_id="xxx"

terraform init
terraform plan
terraform apply
```

