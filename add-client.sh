#!/usr/bin/env bash

# Copy make_config.sh files to the client-configs directory
cp ~/aws-openvpn-server/make-config.sh ~/client-configs/make-config.sh
cp ~/aws-openvpn-server/build-key.sh ~/client-configs/build-key.sh

# Generate client certificate
cd ~/openvpn-ca
source vars
./build-key.sh $1

# Generate client configurations
cd ~/client-configs
./make-config.sh $1
