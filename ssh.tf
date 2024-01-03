data "external" "github_ssh_keys" {
  for_each = toset(var.github_usernames)

  program = ["bash", "-c", "curl -s https://api.github.com/users/${each.key}/keys | jq -r '.[0] | {ssh_key: .key}'"]
}

resource "hcloud_ssh_key" "default" {
  for_each = data.external.github_ssh_keys

  name       = each.key
  public_key = each.value.result.ssh_key
}