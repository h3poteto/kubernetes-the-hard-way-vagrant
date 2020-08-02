#!/bin/bash
# Run in each worker

# We have to disable firewall, because it will block some packets and coredns can not connect the cluster.

sudo pacman -Sy --noconfirm
sudo pacman -S ufw --noconfirm
sudo ufw disable

