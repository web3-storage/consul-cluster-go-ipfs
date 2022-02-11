# consul-cluster-go-ipfs
🚧 WIP 🚧
## packer
Packer configuration to build AMIs and register with HCP.  To build packer images:
```
# export HCP config for your session
export HCP_CLIENT_ID=
export HCP_CLIENT_SECRET=

cd packer

# init packer plugins and lint template
make init

# build AMI images and register with HCP
make build
```
## terraform
### test-node
Barebones test instance to validate packer images.  To deploy test-node:
```
# export HCP config for your session
export HCP_CLIENT_ID=
export HCP_CLIENT_SECRET=

cd terraform/test-node

# init terraform plugins and modules
make init

# deploy test-node instance
make build
```
### ipfs-node
Preconfigured ipfs-node.  To deploy ipfs-node:
```
# export HCP config for your session
export HCP_CLIENT_ID=
export HCP_CLIENT_SECRET=

cd terraform/ipfs-node

# init terraform plugins and modules
make init

# deploy ipfs-node instance
make build
```
