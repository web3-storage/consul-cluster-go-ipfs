.PHONY: all clean init build

all: init build

# Remove any built packer output
clean:
	-rm packer*.output

# Check for specific environment variables
env-%:
	@ if [ "${${*}}" = "" ]; then \
		echo "Environment variable $* not set"; \
		exit 1; \
	fi

# Init packer template
init:
	packer init .
	packer fmt .

# Build packer image
build: env-HCP_CLIENT_ID env-HCP_CLIENT_SECRET
	packer build ubuntu-focal.pkr.hcl
