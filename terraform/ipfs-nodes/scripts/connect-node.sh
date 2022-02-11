TF_STATE="../terraform.tfstate"
KEY="../secrets/$(terraform output -raw -state=$TF_STATE node_ssh_key_pair)"
USER="ubuntu"
HOST=$(terraform output -raw -state=../terraform.tfstate node_public_dns)

ssh -i $KEY $USER@$HOST