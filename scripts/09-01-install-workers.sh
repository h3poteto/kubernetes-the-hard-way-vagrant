#!/bin/bash
# Run in each worker

wget -q --show-progress --https-only --timestamping \
	https://github.com/kubernetes-sigs/cri-tools/releases/download/v1.19.0/crictl-v1.19.0-linux-amd64.tar.gz \
	https://github.com/opencontainers/runc/releases/download/v1.0.0-rc92/runc.amd64 \
	https://github.com/containernetworking/plugins/releases/download/v0.8.7/cni-plugins-linux-amd64-v0.8.7.tgz \
	https://github.com/containerd/containerd/releases/download/v1.4.1/containerd-1.4.1-linux-amd64.tar.gz \
	https://storage.googleapis.com/kubernetes-release/release/v1.19.4/bin/linux/amd64/kubectl \
	https://storage.googleapis.com/kubernetes-release/release/v1.19.4/bin/linux/amd64/kube-proxy \
	https://storage.googleapis.com/kubernetes-release/release/v1.19.4/bin/linux/amd64/kubelet

sudo mkdir -p \
	/etc/cni/net.d \
	/opt/cni/bin \
	/var/lib/kubelet \
	/var/lib/kube-proxy \
	/var/lib/kubernetes \
	/var/run/kubernetes

mkdir -p containerd
tar -xvf crictl-v1.19.0-linux-amd64.tar.gz
tar -xvf containerd-1.4.1-linux-amd64.tar.gz -C containerd
sudo tar -xvf cni-plugins-linux-amd64-v0.8.7.tgz -C /opt/cni/bin/
sudo mv runc.amd64 runc
chmod +x crictl kubectl kube-proxy kubelet runc 
sudo mv crictl kubectl kube-proxy kubelet runc /usr/bin/
sudo mv containerd/bin/* /bin/
rm -rf containerd

