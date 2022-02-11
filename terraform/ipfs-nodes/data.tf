provider "aws" {
  region = var.region
}

locals {
  account_id       = data.aws_caller_identity.current.account_id
  region           = data.aws_region.current.name
  consul_ssm_param = "consul/*"

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
      type             = "ingress"
      from_port        = 4001
      to_port          = 4001
      protocol         = "-1"
      cidr_blocks      = [data.aws_vpc.default.cidr_block]
    },
    {
      type             = "ingress"
      from_port        = 5001
      to_port          = 5001
      protocol         = "tcp"
      cidr_blocks      = [data.aws_vpc.default.cidr_block]
    },
    {
      type             = "ingress"
      from_port        = 8080
      to_port          = 8080
      protocol         = "tcp"
      cidr_blocks      = [data.aws_vpc.default.cidr_block]
    },
  ]
}

data "aws_region" "current" {}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity
data "aws_caller_identity" "current" {}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "default" {
  vpc_id = data.aws_vpc.default.id
}

data "aws_subnet" "default" {
  for_each = data.aws_subnet_ids.default.ids
  id       = each.value
}

# HCP stored packer config
data "hcp_packer_iteration" "ubuntu" {
  bucket_name = "base-ubuntu"
  channel     = "development"
}

# HCP stored packer config
data "hcp_packer_image" "ubuntu_us_west_2" {
  bucket_name    = "base-ubuntu"
  cloud_provider = "aws"
  iteration_id   = data.hcp_packer_iteration.ubuntu.ulid
  region         = "us-west-2"
}
