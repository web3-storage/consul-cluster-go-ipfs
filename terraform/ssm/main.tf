provider "aws" {
  alias  = "us-east-1"
  region = "us-east-1"
}

provider "aws" {
  alias  = "us-west-2"
  region = "us-west-2"
}

locals {
  regions_enabled = ["us-east-1", "us-west-2"]
}

data "local_file" "consul_ca" {
  for_each = toset(local.regions_enabled)
  filename = "secrets/client_config_bundle_consul_consul-${each.key}/ca.pem"
}

data "local_file" "consul_acl" {
  for_each = toset(local.regions_enabled)
  filename = "secrets/client_config_bundle_consul_consul-${each.key}/my_client_acl.json"
}

data "local_file" "consul_config" {
  for_each = toset(local.regions_enabled)
  filename = "secrets/client_config_bundle_consul_consul-${each.key}/my_client_config.json"
}

data "local_file" "service_api" {
  for_each = toset(local.regions_enabled)
  filename = "secrets/client_config_bundle_consul_consul-${each.key}/service_api.json"
}

data "local_file" "service_gateway" {
  for_each = toset(local.regions_enabled)
  filename = "secrets/client_config_bundle_consul_consul-${each.key}/service_gateway.json"
}

data "local_file" "service_node_helper" {
  for_each = toset(local.regions_enabled)
  filename = "secrets/client_config_bundle_consul_consul-${each.key}/service_node_helper.json"
}

data "local_file" "service_webui" {
  for_each = toset(local.regions_enabled)
  filename = "secrets/client_config_bundle_consul_consul-${each.key}/service_webui.json"
}

module "ssm_us-east-1" {
  source = "../modules/aws-ssm-parameter-store"
  providers = {
    aws = aws.us-east-1
  }
  parameter_write = [
    {
      name      = "/consul/consul_ca"
      value     = data.local_file.consul_ca["us-east-1"].content
      type      = "SecureString"
      overwrite = "true"
      tier      = "Advanced"
    },
    {
      name      = "/consul/consul_acl"
      value     = data.local_file.consul_acl["us-east-1"].content
      type      = "SecureString"
      overwrite = "true"
      tier      = "Advanced"
    },
    {
      name      = "/consul/consul_config"
      value     = data.local_file.consul_config["us-east-1"].content
      type      = "SecureString"
      overwrite = "true"
      tier      = "Advanced"
    },
    {
      name      = "/consul/service_api"
      value     = data.local_file.service_api["us-east-1"].content
      type      = "SecureString"
      overwrite = "true"
      tier      = "Advanced"
    },
    {
      name      = "/consul/service_gateway"
      value     = data.local_file.service_gateway["us-east-1"].content
      type      = "SecureString"
      overwrite = "true"
      tier      = "Advanced"
    },
    {
      name      = "/consul/service_node_helper"
      value     = data.local_file.service_node_helper["us-east-1"].content
      type      = "SecureString"
      overwrite = "true"
      tier      = "Advanced"
    },
    {
      name      = "/consul/service_webui"
      value     = data.local_file.service_webui["us-east-1"].content
      type      = "SecureString"
      overwrite = "true"
      tier      = "Advanced"
    }
  ]
}

module "ssm_us-west-2" {
  source = "../modules/aws-ssm-parameter-store"
  providers = {
    aws = aws.us-west-2
  }
  parameter_write = [
    {
      name      = "/consul/consul_ca"
      value     = data.local_file.consul_ca["us-west-2"].content
      type      = "SecureString"
      overwrite = "true"
      tier      = "Advanced"
    },
    {
      name      = "/consul/consul_acl"
      value     = data.local_file.consul_acl["us-west-2"].content
      type      = "SecureString"
      overwrite = "true"
      tier      = "Advanced"
    },
    {
      name      = "/consul/consul_config"
      value     = data.local_file.consul_config["us-west-2"].content
      type      = "SecureString"
      overwrite = "true"
      tier      = "Advanced"
    },
      {
      name      = "/consul/service_api"
      value     = data.local_file.service_api["us-west-2"].content
      type      = "SecureString"
      overwrite = "true"
      tier      = "Advanced"
    },
    {
      name      = "/consul/service_gateway"
      value     = data.local_file.service_gateway["us-west-2"].content
      type      = "SecureString"
      overwrite = "true"
      tier      = "Advanced"
    },
    {
      name      = "/consul/service_node_helper"
      value     = data.local_file.service_node_helper["us-west-2"].content
      type      = "SecureString"
      overwrite = "true"
      tier      = "Advanced"
    },
    {
      name      = "/consul/service_webui"
      value     = data.local_file.service_webui["us-west-2"].content
      type      = "SecureString"
      overwrite = "true"
      tier      = "Advanced"
    }
  ]
}
