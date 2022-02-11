.PHONY: all clean init build

all: init build

# Remove any output
clean:
	echo "clean"

# Check for specific environment variables
env-%:
	@ if [ "${${*}}" = "" ]; then \
		echo "Environment variable $* not set"; \
		exit 1; \
	fi

# Init terraform plugins and modules
init:
	terraform init

# Apply terraform configuration
build: env-HCP_CLIENT_ID env-HCP_CLIENT_SECRET
	terraform apply

# Destroy terraform configuration
destroy: env-HCP_CLIENT_ID env-HCP_CLIENT_SECRET
	terraform destroy
