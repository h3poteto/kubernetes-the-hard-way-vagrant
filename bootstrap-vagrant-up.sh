#!/bin/bash

CURRENT_PATH=$(pwd)

cat <<EOF | tee ~/.config/systemd/user/vagrant.service
[Unit]
Description=vagrant up
After=network.target
ConditionPathExists=${CURRENT_PATH}

[Service]
Type=forking
ExecStart=${CURRENT_PATH}/vagrant-up.sh
Restart=no
TimeoutSec=10min

[Install]
WantedBy=default.target
EOF
