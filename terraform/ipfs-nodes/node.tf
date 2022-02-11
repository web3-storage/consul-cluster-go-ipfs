# https://github.com/cloudposse/terraform-aws-ec2-instance
module "node" {
  name = "node"
  source                      = "cloudposse/ec2-instance/aws"
  version                     = "0.40.0"
  context                     = module.this.context
  ami                         = data.hcp_packer_image.ubuntu_us_west_2.cloud_image_id
  ami_owner                   = data.aws_caller_identity.current.account_id
  ssh_key_pair                = module.aws_key_pair.key_name
  vpc_id                      = data.aws_vpc.default.id
  subnet                      = tolist(data.aws_subnet_ids.default.ids)[0]
  assign_eip_address          = var.assign_eip_address
  associate_public_ip_address = var.associate_public_ip_address
  instance_type               = var.instance_type
  security_group_rules        = local.security_group_rules
  instance_profile            = aws_iam_instance_profile.profile.name
  user_data = templatefile("user-data.sh", {
    region = local.region
  })
  # disable IMDSv2 metadata api requirement
  # https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/configuring-instance-metadata-service.html
  # https://github.com/cloudposse/terraform-aws-ec2-instance#input_metadata_http_tokens_required
  metadata_http_endpoint_enabled = true
  metadata_http_tokens_required  = false
}

output "node_public_ip" {
  description = "Public IP of instance (or EIP)"
  value       = module.node.public_ip
}

output "node_private_ip" {
  description = "Private IP of instance"
  value       = module.node.private_ip
}

output "node_private_dns" {
  description = "Private DNS of instance"
  value       = module.node.private_dns
}

output "node_public_dns" {
  description = "Public DNS of instance (or DNS of EIP)"
  value       = module.node.public_dns
}

output "node_id" {
  description = "Disambiguated ID of the instance"
  value       = module.node.id
}

output "node_arn" {
  description = "ARN of the instance"
  value       = module.node.arn
}

output "node_name" {
  description = "Instance name"
  value       = module.node.name
}

output "node_ssh_key_pair" {
  description = "Name of the SSH key pair provisioned on the instance"
  value       = module.node.ssh_key_pair
}

output "node_security_group_ids" {
  description = "IDs on the AWS Security Groups associated with the instance"
  value       = module.node.security_group_ids
}

output "node_role" {
  description = "Name of AWS IAM Role associated with the instance"
  value       = module.node.role
}

output "node_additional_eni_ids" {
  description = "Map of ENI to EIP"
  value       = module.node.additional_eni_ids
}

output "node_ebs_ids" {
  description = "IDs of EBSs"
  value       = module.node.ebs_ids
}

output "node_primary_network_interface_id" {
  description = "ID of the instance's primary network interface"
  value       = module.node.primary_network_interface_id
}

output "node_security_group_id" {
  value       = module.node.security_group_id
  description = "EC2 instance Security Group ID"
}

output "node_security_group_arn" {
  value       = module.node.security_group_arn
  description = "EC2 instance Security Group ARN"
}

output "node_security_group_name" {
  value       = module.node.security_group_name
  description = "EC2 instance Security Group name"
}
