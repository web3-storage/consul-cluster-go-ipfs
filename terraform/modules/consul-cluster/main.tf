provider "aws" {
  region = var.region
}

data "aws_vpc" "default" {
  default = true
}

resource "hcp_hvn" "hvn" {
  hvn_id         = var.hvn_id
  cloud_provider = "aws"
  region         = var.region
  cidr_block     = var.cidr_block
}

resource "hcp_consul_cluster" "cluster" {
  cluster_id              = var.cluster_id
  hvn_id                  = hcp_hvn.hvn.hvn_id
  tier                    = "development"
  min_consul_version      = "1.10.6"
  public_endpoint         = true
  auto_hvn_to_hvn_peering = true
  primary_link            = var.federation != false ? var.primary_consul_cluster_name : null
}

resource "hcp_aws_network_peering" "peer" {
  hvn_id          = hcp_hvn.hvn.hvn_id
  peering_id      = var.peering_id
  peer_vpc_id     = data.aws_vpc.default.id
  peer_account_id = data.aws_vpc.default.owner_id
  peer_vpc_region = var.region
}

resource "hcp_hvn_route" "peer_route" {
  hvn_link         = hcp_hvn.hvn.self_link
  hvn_route_id     = var.route_id
  destination_cidr = data.aws_vpc.default.cidr_block
  target_link      = hcp_aws_network_peering.peer.self_link
}

resource "aws_vpc_peering_connection_accepter" "peer" {
  vpc_peering_connection_id = hcp_aws_network_peering.peer.provider_peering_id
  auto_accept               = true
}
