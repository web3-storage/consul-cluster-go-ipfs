packer {
  required_plugins {
    amazon = {
      version = ">= 1.0.1"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

locals {
  playbook_file  = "${path.root}/../ansible/playbook.yml"
}

variable "consul_version" {
  type    = string
  default = "1.10.3"
}

variable "ipfs_version" {
  type    = string
  default = "0.11.0"
}

variable "nodejs_version" {
  type    = string
  default = "17"
}

source "amazon-ebs" "base_us_east_2" {
  region = "us-east-2"
  source_ami_filter {
    filters = {
      virtualization-type = "hvm"
      name                = "ubuntu/images/*ubuntu-focal-20.04-amd64-server-*"
      root-device-type    = "ebs"
    }
    owners      = ["099720109477"]
    most_recent = true
  }
  instance_type  = "t2.small"
  ssh_username   = "ubuntu"
  ssh_agent_auth = false
  ami_name       = "base-us-east-2-{{timestamp}}"
}

source "amazon-ebs" "base_us_west_2" {
  region = "us-west-2"
  source_ami_filter {
    filters = {
      virtualization-type = "hvm"
      name                = "ubuntu/images/*ubuntu-focal-20.04-amd64-server-*"
      root-device-type    = "ebs"
    }
    owners      = ["099720109477"]
    most_recent = true
  }
  instance_type  = "t2.small"
  ssh_username   = "ubuntu"
  ssh_agent_auth = false
  ami_name       = "base-us-west-2-{{timestamp}}"
}

build {
  hcp_packer_registry {
    bucket_name = "base-ubuntu"
    description = <<EOT
Some test description about the image being published to HCP Packer Registry.
    EOT
    labels = {
      "os"   = "ubuntu-focal-20.04",
      "arch" = "amd64"
    }
  }
  sources = [
    "source.amazon-ebs.base_us_east_2",
    "source.amazon-ebs.base_us_west_2"
  ]
  provisioner "file" {
    source      = "./../terraform/modules/install-ipfs"
    destination = "/tmp/install-ipfs"
  }
  provisioner "file" {
    source      = "./../terraform/modules/run-ipfs"
    destination = "/tmp/run-ipfs"
  }
  provisioner "file" {
    source      = "./../terraform/modules/run-node-helper"
    destination = "/tmp/run-node-helper"
  }
  provisioner "shell" {
    scripts = [
      "scripts/update-apt.sh",
      "scripts/install-common.sh",
      "scripts/install-consul.sh",
      "scripts/install-ipfs.sh",
      "scripts/install-nodejs.sh"
    ]
    execute_command = "sudo -S sh -c '{{ .Vars }} {{ .Path }}'"
    environment_vars = [
      "CONSUL_VERSION=${var.consul_version}",
      "IPFS_VERSION=${var.ipfs_version}",
      "NODEJS_VERSION=${var.nodejs_version}"
    ]
    pause_before = "30s"
  }
  provisioner "shell-local" {
    command = "rm files/node-helper.tar && cd ../node-helper && tar -cf ../packer/files/node-helper.tar --exclude node_modules ."
  }
  provisioner "file" {
    source      = "./files"
    destination = "/tmp/"
  }
  provisioner "shell" {
    scripts = [
      "scripts/install-node-helper.sh"
    ]
    execute_command = "sudo -S sh -c '{{ .Vars }} {{ .Path }}'"
  }
}