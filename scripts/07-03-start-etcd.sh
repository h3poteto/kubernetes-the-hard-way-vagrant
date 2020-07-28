#!/bin/bash
# Run in each master

sudo systemctl daemon-reload
sudo systemctl enable etcd
sudo systemctl start etcd

