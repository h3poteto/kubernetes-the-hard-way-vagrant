#!/bin/bash
# Run in master

curl -fsSLo weave-daemonset.yaml "https://cloud.weave.works/k8s/net?k8s-version=1.19.4&env.CHECKPOINT_DISABLE=1&env.IPALLOC_RANGE=10.200.0.0/16"
kubectl apply -f weave-daemonset.yaml
