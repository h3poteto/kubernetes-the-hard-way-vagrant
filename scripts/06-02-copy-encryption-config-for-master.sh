#!/bin/bash
# Run in host OS

for instance in master; do
	vagrant scp encryption-config.yaml ${instance}:~/
done


