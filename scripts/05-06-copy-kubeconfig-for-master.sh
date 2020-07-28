#!/bin/bash
# Run in host OS

for instance in master; do
	vagrant scp admin.kubeconfig ${instance}:~/
	vagrant scp kube-controller-manager.kubeconfig ${instance}:~/
	vagrant scp kube-scheduler.kubeconfig ${instance}:~/
done

