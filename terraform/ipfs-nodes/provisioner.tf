# https://www.terraform.io/docs/language/resources/provisioners/null_resource.html
# https://www.terraform.io/docs/language/resources/provisioners/remote-exec.html
# https://www.hashicorp.com/resources/ansible-terraform-better-together
# https://github.com/terraform-aws-modules/terraform-aws-ec2-instance/issues/48
# resource "null_resource" "ansible" {
#
#  # Changes to the instance will cause the null_resource to be re-executed
#  triggers = {
#    instance_ids = module.ec2_instance.id
#  }
#
#  # Running the remote provisioner like this ensures that ssh is up and running
#  # before running the local provisioner
#
#  provisioner "remote-exec" {
#    inline = ["sudo apt update", "echo Done!"]
#  }
#
#  connection {
#    host        = module.ec2_instance.public_ip
#    type        = "ssh"
#    user        = "ubuntu"
#    private_key = module.aws_key_pair.private_key
#  }
#
#  # Note that the -i flag expects a comma separated list, so the trailing comma is essential!
#  provisioner "local-exec" {
#    command = "echo ansible..."
#    # command = "ansible-playbook ../ansible/main.yml -u ubuntu -i '${module.ec2_instance.public_ip}' "
#  }
#}