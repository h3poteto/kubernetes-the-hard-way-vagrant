#!/bin/bash
# Run in host OS

vagrant ssh master \
	--command "kubectl get nodes --kubeconfig admin.kubeconfig"
