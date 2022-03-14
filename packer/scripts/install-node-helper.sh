#!/usr/bin/env bash

set -euf -o pipefail

# unpack tarball
mkdir -p /opt/node-helper
cd /tmp
tar xf files/node-helper.tar -C /opt/node-helper
rm files/node-helper.tar

# npm install and build next.js app
cd /opt/node-helper
npm install
npm run build

# copy over run service script
cp /tmp/run-node-helper/run-node-helper /opt/node-helper/run-node-helper
chown -R ipfs:ipfs /opt/node-helper
chmod a+x /opt/node-helper/run-node-helper