#!/bin/bash

kubectl get componentstatuses --kubeconfig admin.kubeconfig

curl -H "Host: kubernetes.default.svc.cluster.local" -i http://127.0.0.1/healthz

curl --cacert ca.pem https://10.240.0.10:6443/version
