variable "region" {
  type        = string
  description = "AWS region"
}

variable "associate_public_ip_address" {
  type        = bool
  description = "Associate a public IP address with the instance"
}

variable "assign_eip_address" {
  type        = bool
  description = "Assign an Elastic IP address to the instance"
}

variable "instance_type" {
  type        = string
  description = "The type of the instance"
}

variable "ssh_public_key_path" {
  type        = string
  description = "Path to SSH public key directory (e.g. `/secrets`)"
}

variable "security_group_rules" {
  type        = list(any)
  description = <<-EOT
    A list of maps of Security Group rules. 
    The values of map is fully complated with `aws_security_group_rule` resource. 
    To get more info see https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule .
  EOT
}

variable "consul_datacenters" {
  type        = map(string)
  description = "Consul datacenters per region"
}

variable "consul_addresses" {
  type        = map(string)
  description = "Consul provider endpoints (public for development) per region"
}

variable "consul_tokens" {
  type        = map(string)
  description = "Consul access token per region"
  sensitive = true
}
