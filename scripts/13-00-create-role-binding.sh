#!/bin/bash
# Run in master

cat <<EOF | tee /tmp/cluster-role-binding.yaml
kind: ClusterRoleBinding
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  name: akira-masters-all
subjects:
- kind: User
  name: akira
  apiGroup: rbac.authorization.k8s.io
roleRef:
  kind: ClusterRole
  name: cluster-admin
  apiGroup: rbac.authorization.k8s.io
EOF

kubectl apply -f /tmp/cluster-role-binding.yaml

