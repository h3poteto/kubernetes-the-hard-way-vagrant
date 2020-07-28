#!/bin/bash
# Run in host OS

for instance in node-0 node-1; do
  vagrant scp ca.pem ${instance}:~/
  vagrant scp ${instance}-key.pem ${instance}:~/
  vagrant scp ${instance}.pem ${instance}:~/
done
