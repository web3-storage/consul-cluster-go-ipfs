module "consul_us-west-2" {
  source     = "../modules/consul-cluster"
  region     = "us-west-2"
  hvn_id     = "hvn-us-west-2"
  cidr_block = "172.25.16.0/20"
  cluster_id = "consul-us-west-2"
  peering_id = "hvn-us-west-2"
  route_id   = "hvn-us-west-2-default-route"
}

module "consul_us-east-1" {
  source                      = "../modules/consul-cluster"
  region                      = "us-east-1"
  hvn_id                      = "hvn-us-east-1"
  cidr_block                  = "172.26.16.0/20"
  cluster_id                  = "consul-us-east-1"
  peering_id                  = "hvn-us-east-1"
  route_id                    = "hvn-us-east-1-default-route"
  federation                  = true
  primary_consul_cluster_name = module.consul_us-west-2.consul_endpoint
}