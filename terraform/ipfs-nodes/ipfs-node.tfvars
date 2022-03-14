enabled = true

region = "us-west-2"

namespace = "pl"

stage = "dev"

name = "ipfs-node"

assign_eip_address = false

associate_public_ip_address = true

instance_type = "t3.micro"

security_group_rules = [
  {
    type        = "egress"
    from_port   = 0
    to_port     = 65535
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  },
  {
    type        = "ingress"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  },
  {
    type        = "ingress"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  },
  {
    type        = "ingress"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  },
  {
    type        = "ingress"
    from_port   = 53
    to_port     = 53
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  },
]

# absolute path
ssh_public_key_path = "./secrets"

# consul config
consul_datacenters = {
  "us-west-2" : "consul-us-west-2",
  "consul-us-east-1" : "consul-us-east-1"
}
consul_addresses   = {
  "us-west-2" : "https://consul-us-west-2.consul.68ea4544-ab68-47d8-829e-90116be924d5.aws.hashicorp.cloud",
  "us-east-1" : "https://consul-us-east-1.consul.68ea4544-ab68-47d8-829e-90116be924d5.aws.hashicorp.cloud"
}