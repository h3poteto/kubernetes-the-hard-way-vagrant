#!/bin/bash

for instance in node-1; do
  cp ca.pem ~/ca.pem
  cp ${instance}-key.pem ~/${instance}-key.pem
  cp ${instance}.pem ~/${instance}.pem
done
