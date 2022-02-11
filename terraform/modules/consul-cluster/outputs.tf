# https://registry.terraform.io/providers/hashicorp/hcp/latest/docs/resources/consul_cluster#read-only

output "consul_endpoint" {
  value = hcp_consul_cluster.cluster.self_link
}
