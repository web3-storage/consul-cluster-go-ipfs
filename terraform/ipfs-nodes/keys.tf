# https://github.com/cloudposse/terraform-aws-key-pair
module "aws_key_pair" {
  source              = "cloudposse/key-pair/aws"
  version             = "0.16.1"
  namespace           = module.this.namespace
  stage               = module.this.stage
  name                = module.this.name
  attributes          = module.this.attributes
  ssh_public_key_path = var.ssh_public_key_path
  generate_ssh_key    = true
}

output "key_name" {
  value       = module.aws_key_pair.key_name
  description = "Name of SSH key"
}

output "public_key" {
  value       = module.aws_key_pair.public_key
  description = "Content of the generated public key"
}

output "public_key_filename" {
  description = "Public Key Filename"
  value       = module.aws_key_pair.public_key_filename
}

output "private_key_filename" {
  description = "Private Key Filename"
  value       = module.aws_key_pair.private_key_filename
}
