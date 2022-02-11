#!/usr/bin/env bash

set -euf -o pipefail

# Set up the latest Node.js repository and add official GPG key
curl -sL "https://deb.nodesource.com/setup_$NODEJS_VERSION.x" | bash -

# Install Node.js
apt-get update -qq && apt-get install -y nodejs

# Upgrade to the latest of NPM
npm install -g npm
