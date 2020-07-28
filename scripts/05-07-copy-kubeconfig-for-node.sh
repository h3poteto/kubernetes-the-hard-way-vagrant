#!/bin/bash
# Run in host OS

for instance in node-1 node-2; do
	vagrant scp ${instance}.kubeconfig ${instance}:~/
	vagrant scp kube-proxy.kubeconfig ${instance}:~/
done
