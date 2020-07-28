#!/bin/bash
# Run in host OS

for instance in master; do
	vagrant scp ca.pem ${instance}:~/
	vagrant scp ca-key.pem ${instance}:~/
	vagrant scp kubernetes.pem ${instance}:~/
	vagrant scp kubernetes-key.pem ${instance}:~/
	vagrant scp service-account.pem ${instance}:~/
	vagrant scp service-account-key.pem ${instance}:~/
done
