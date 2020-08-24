#!/bin/bash

cd /home/h3poteto/vagrant/kubernetes-the-hard-way-vagrant
vagrant up master

# Wait until start master components
sleep 120
vagrant up node-0
vagrant up node-1


