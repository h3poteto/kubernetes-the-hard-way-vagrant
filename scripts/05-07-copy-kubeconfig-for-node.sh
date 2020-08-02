#!/bin/bash
# Run in host OS

for instance in node-0 node-1; do
	vagrant scp ${instance}.kubeconfig ${instance}:~/
	vagrant scp kube-proxy.kubeconfig ${instance}:~/
done
