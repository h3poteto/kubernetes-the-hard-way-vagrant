#!/bin/bash

CURRENT_PATH=$(pwd)

cat <<EOF | sudo tee /etc/systemd/system/vagrant-up.service
[Unit]
Description=vagrant up
After=network.target
ConditionPathExists=${CURRENT_PATH}

[Service]
User=h3poteto
Group=h3poteto
Type=forking
ExecStart=${CURRENT_PATH}/vagrant-up.sh
Restart=no
TimeoutSec=15min

[Install]
WantedBy=multi-user.target
EOF
