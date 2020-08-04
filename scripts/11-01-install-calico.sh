#!/bin/bash
# Run in master

curl https://docs.projectcalico.org/manifests/calico-etcd.yaml -o calico.yaml

## After download calico.yaml, rewrite this file
## 1st Secret
# Write these three entry to connect usign tls for etcd
# etcd-key: -> cat kubernetes-key.pem | base64 -w 0
# etcd-cert: -> cat kubernetes.pem | base64 -w 0
# etcd-ca: -> cat ca.pem | base64 -w 0

## 2nd ConfigMap
# etcd_endpoints: "https://10.240.0.10:2379"  # etcd endpoint in master node
# etcd_ca: "/calico-secrets/etcd-ca" # "ca.pem"
# etcd_cert: "/calico-secrets/etcd-cert" # "kubernetes.pem"
# etcd_key: "/calico-secrets/etcd-key" # "kubernetes-key.pem"

## 3rd DaemonSet
# - name: CALICO_IPV4POOL_CIDR
#   value: "10.200.0.0/16"  # Pod network cidr

# After that apply calico.yaml
# kubectl apply -f calico.yaml
