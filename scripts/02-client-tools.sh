#!/bin/bash
# Run in master

wget -q --show-progress --https-only --timestamping \
  https://storage.googleapis.com/kubernetes-the-hard-way/cfssl/1.4.1/linux/cfssl \
  https://storage.googleapis.com/kubernetes-the-hard-way/cfssl/1.4.1/linux/cfssljson
chmod +x cfssl cfssljson
sudo mv cfssl cfssljson /usr/bin/

cfssl version
cfssljson --version

wget https://storage.googleapis.com/kubernetes-release/release/v1.19.4/bin/linux/amd64/kubectl
chmod +x kubectl
sudo mv kubectl /usr/bin/

kubectl version --client

