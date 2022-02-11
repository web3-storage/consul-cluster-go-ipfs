variable "region" {
  type        = string
  description = "AWS region"
}

variable "hvn_id" {
  type        = string
  description = "The ID of the HCP HVN."
}

variable "cidr_block" {
  type        = string
  description = "172.25.16.0/20"
}

variable "cluster_id" {
  description = "The ID of the HCP Consul cluster."
  type        = string
}

variable "peering_id" {
  description = "The ID of the HCP peering connection."
  type        = string
}

variable "route_id" {
  description = "The ID of the HCP HVN route."
  type        = string
}

variable "federation" {
  description = "Flag to enable Consul Federation. Defaults to false"
  type        = bool
  default     = false
}

variable "primary_consul_cluster_name" {
  description = "Primary Consul cluster name (id) that secondary clusters will be federating with."
  type        = string
  default     = ""
}
