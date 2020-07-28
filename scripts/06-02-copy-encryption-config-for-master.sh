#!/bin/bash
# Run in master

for instance in master; do
	vagrant scp encryption-config.yaml ${instance}:~/
done


