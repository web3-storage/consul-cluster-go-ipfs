#!/bin/bash
set -e

# Send the log output from this script to user-data.log, syslog, and the console
# From: https://alestic.com/2010/12/ec2-user-data-output/
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1

# read consul secrets + config from aws ssm
aws ssm get-parameter --name /consul/consul_ca --with-decryption --output text --query Parameter.Value --region "${region}" | sudo tee /opt/consul/config/ca.pem
aws ssm get-parameter --name /consul/consul_acl --with-decryption --output text --query Parameter.Value --region "${region}" | sudo tee /opt/consul/config/my_consul_acl.json
aws ssm get-parameter --name /consul/consul_config --with-decryption --output text --query Parameter.Value --region "${region}" | sudo tee /opt/consul/config/my_consul_config.json
# read service definitions from aws ssm
aws ssm get-parameter --name /consul/service_api --with-decryption --output text --query Parameter.Value --region "${region}" | sudo tee /opt/consul/config/service_api.json
aws ssm get-parameter --name /consul/service_gateway --with-decryption --output text --query Parameter.Value --region "${region}" | sudo tee /opt/consul/config/service_gateway.json
aws ssm get-parameter --name /consul/service_node_helper --with-decryption --output text --query Parameter.Value --region "${region}" | sudo tee /opt/consul/config/service_node_helper.json
aws ssm get-parameter --name /consul/service_webui --with-decryption --output text --query Parameter.Value --region "${region}" | sudo tee /opt/consul/config/service_webui.json
# ensure consul user owns folder
sudo chown -R consul:consul /opt/consul

# start consul agent
sudo /opt/consul/bin/run-consul --client

# start ipfs service
sudo chown -R ipfs:ipfs /opt/ipfs
sudo /opt/ipfs/bin/run-ipfs

# start node helper service
sudo /opt/node-helper/run-node-helper --user ipfs