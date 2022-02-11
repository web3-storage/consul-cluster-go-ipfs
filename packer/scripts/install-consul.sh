#!/usr/bin/env bash

set -euf -o pipefail

git clone --branch v0.11.0 https://github.com/hashicorp/terraform-aws-consul.git /tmp/terraform-aws-consul
/tmp/terraform-aws-consul/modules/install-consul/install-consul --version $CONSUL_VERSION
/tmp/terraform-aws-consul/modules/setup-systemd-resolved/setup-systemd-resolved