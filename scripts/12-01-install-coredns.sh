#!/bin/bash
# Run in master

kubectl apply -f https://raw.githubusercontent.com/h3poteto/kubernetes-the-hard-way-vagrant/master/coredns-1.7.0.yaml

kubectl get pods -l k8s-app=kube-dns -n kube-system


