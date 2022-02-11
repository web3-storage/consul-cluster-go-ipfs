#!/usr/bin/env bash

set -euf -o pipefail

apt-get install -y \
  build-essential \
  htop \
  jq \
  awscli \
  curl \
  wget \
  git \
  unzip