#!/bin/bash
# Run in master

kubectl config set-cluster kubernetes-the-hard-way \
	--certificate-authority=ca.pem \
	--embed-certs=true \
	--server=https://127.0.0.1:6443 \
	--kubeconfig=akira.kubeconfig

kubectl config set-credentials akira \
	--client-certificate=akira.pem \
	--client-key=akira-key.pem \
	--embed-certs=true \
	--kubeconfig=akira.kubeconfig

kubectl config set-context user \
	--cluster=kubernetes-the-hard-way \
	--user=akira \
	--kubeconfig=akira.kubeconfig

kubectl config use-context user --kubeconfig=akira.kubeconfig
