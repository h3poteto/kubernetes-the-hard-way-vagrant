#!/bin/bash

for instance in node-1; do
	cp ${instance}.kubeconfig ~/
	cp kube-proxy.kubeconfig ~/
done
