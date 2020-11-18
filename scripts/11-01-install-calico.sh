#!/bin/bash
# Run in master

curl https://docs.projectcalico.org/manifests/calico.yaml -O

## Rewrite CALICO_IPV4POOL_CIDR
# - name: CALICO_IPV4POOL_CIDR
#   value: "10.200.0.0/16"
# And kubectl apply -f calico.yaml
