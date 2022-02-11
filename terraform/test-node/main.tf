provider "hcp" {}

provider "aws" {
  region = var.region
}

data "hcp_packer_iteration" "ubuntu" {
  bucket_name = "base-ubuntu"
  channel     = "development"
}

data "hcp_packer_image" "ubuntu_us_west_2" {
  bucket_name    = "base-ubuntu"
  cloud_provider = "aws"
  iteration_id   = data.hcp_packer_iteration.ubuntu.ulid
  region         = "us-west-2"
}

resource "aws_instance" "test_node" {
  ami           = data.hcp_packer_image.ubuntu_us_west_2.cloud_image_id
  instance_type = "t2.micro"
}
