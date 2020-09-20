#!/bin/bash
# Run in master

KUBERNETES_PUBLIC_ADDRESS=192.168.10.11

kubectl config set-cluster kubernetes-the-hard-way \
	--certificate-authority=ca.pem \
	--embed-certs=true \
	--server=https://${KUBERNETES_PUBLIC_ADDRESS}:6443

kubectl config set-credentials akira \
	--client-certificate=akira.pem \
	--client-key=akira-key.pem

kubectl config set-context user \
	--cluster=kubernetes-the-hard-way \
	--user=akira

kubectl config use-context user
