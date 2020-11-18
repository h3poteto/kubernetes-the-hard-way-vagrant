.PHONY: clean

clean:
	rm scripts/*.yaml
	rm scripts/*.csr
	rm scripts/*.json
	rm scripts/*.kubeconfig
	rm scripts/*.pem
	rm scripts/*.tar.gz
	rm scripts/*.tgz
	rm -rf scripts/etcd-*-linux-amd64

