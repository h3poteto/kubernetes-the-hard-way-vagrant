# Renew certificates of API server
## Create new certificates
### Backup the current certificates
```bash
$ vagrant ssh master
[vagrant@master ~]$ mkdir backup
[vagrant@master ~]$ mv kubernetes.pem kubernetes-key.pem backup/
```

### Create new certificates
```bash
[vagrant@master ~]$ cd /provisoning_scripts/
[vagrant@master provisoning_scripts]$ ./04-07-kubernetes-api-server-certificate.sh
2020/08/05 16:17:31 [INFO] generate received request
2020/08/05 16:17:31 [INFO] received CSR
2020/08/05 16:17:31 [INFO] generating key: rsa-2048
2020/08/05 16:17:32 [INFO] encoded CSR
2020/08/05 16:17:32 [INFO] signed certificate with serial number 111111111
```
### Copy certificates
```bash
[h3poteto@atami scripts]$ ./04-09-copy-certs-for-master.sh
Warning: Permanently added '[127.0.0.1]:2222' (ECDSA) to the list of known hosts.
ca.pem                                                                                                                                                                           100% 1318   241.6KB/s   00:00
Warning: Permanently added '[127.0.0.1]:2222' (ECDSA) to the list of known hosts.
ca-key.pem                                                                                                                                                                       100% 1675   432.5KB/s   00:00
Warning: Permanently added '[127.0.0.1]:2222' (ECDSA) to the list of known hosts.
kubernetes.pem                                                                                                                                                                   100% 1671   485.3KB/s   00:00
Warning: Permanently added '[127.0.0.1]:2222' (ECDSA) to the list of known hosts.
kubernetes-key.pem                                                                                                                                                               100% 1675   372.3KB/s   00:00
Warning: Permanently added '[127.0.0.1]:2222' (ECDSA) to the list of known hosts.
service-account.pem                                                                                                                                                              100% 1440   475.2KB/s   00:00
Warning: Permanently added '[127.0.0.1]:2222' (ECDSA) to the list of known hosts.
service-account-key.pem                                                                                                                                                          100% 1679   409.1KB/s   00:00
```

## Re-configure etcd
### Configure etcd
```bash
[vagrant@master provisoning_scripts]$ ./07-02-configure-etcd.sh
[Unit]
Description=etcd
Documentation=https://github.com/coreos

[Service]
Type=notify
ExecStart=/usr/bin/etcd \
  --name master \
  --cert-file=/etc/etcd/kubernetes.pem \
  --key-file=/etc/etcd/kubernetes-key.pem \
  --peer-cert-file=/etc/etcd/kubernetes.pem \
  --peer-key-file=/etc/etcd/kubernetes-key.pem \
  --trusted-ca-file=/etc/etcd/ca.pem \
  --peer-trusted-ca-file=/etc/etcd/ca.pem \
  --peer-client-cert-auth \
  --client-cert-auth \
  --initial-advertise-peer-urls https://10.240.0.10:2380 \
  --listen-peer-urls https://10.240.0.10:2380 \
  --listen-client-urls https://10.240.0.10:2379,https://127.0.0.1:2379 \
  --advertise-client-urls https://10.240.0.10:2379 \
  --initial-cluster-token etcd-cluster-0 \
  --initial-cluster master=https://10.240.0.10:2380 \
  --initial-cluster-state new \
  --data-dir=/var/lib/etcd
Restart=on-failure
RestartSec=5

[Install]
WantedBy=multi-user.target
```

### Restart etcd
```bash
[vagrant@master provisoning_scripts]$ sudo systemctl daemon-reload
[vagrant@master provisoning_scripts]$ sudo systemctl restart etcd
```

### Verify
```bash
[vagrant@master provisoning_scripts]$ ./07-04-verify-etcd.sh
f98dc20bce6225a0, started, master, https://10.240.0.10:2380, https://10.240.0.10:2379, false
```

## Re-configure API server
### Configure API server
```bash
[vagrant@master provisoning_scripts]$ ./08-02-configure-api-server.sh
[Unit]
Description=Kubernetes API Server
Documentation=https://github.com/kubernetes/kubernetes

[Service]
ExecStart=/usr/bin/kube-apiserver \
  --advertise-address=10.240.0.10 \
  --allow-privileged=true \
  --apiserver-count=1 \
  --audit-log-maxage=30 \
  --audit-log-maxbackup=3 \
  --audit-log-maxsize=100 \
  --audit-log-path=/var/log/audit.log \
  --authorization-mode=Node,RBAC \
  --bind-address=0.0.0.0 \
  --client-ca-file=/var/lib/kubernetes/ca.pem \
  --enable-admission-plugins=NamespaceLifecycle,NodeRestriction,LimitRanger,ServiceAccount,DefaultStorageClass,ResourceQuota \
  --etcd-cafile=/var/lib/kubernetes/ca.pem \
  --etcd-certfile=/var/lib/kubernetes/kubernetes.pem \
  --etcd-keyfile=/var/lib/kubernetes/kubernetes-key.pem \
  --etcd-servers=https://10.240.0.10:2379 \
  --event-ttl=1h \
  --encryption-provider-config=/var/lib/kubernetes/encryption-config.yaml \
  --kubelet-certificate-authority=/var/lib/kubernetes/ca.pem \
  --kubelet-client-certificate=/var/lib/kubernetes/kubernetes.pem \
  --kubelet-client-key=/var/lib/kubernetes/kubernetes-key.pem \
  --kubelet-https=true \
  --runtime-config='api/all=true' \
  --service-account-key-file=/var/lib/kubernetes/service-account.pem \
  --service-cluster-ip-range=10.32.0.0/24 \
  --service-node-port-range=30000-32767 \
  --tls-cert-file=/var/lib/kubernetes/kubernetes.pem \
  --tls-private-key-file=/var/lib/kubernetes/kubernetes-key.pem \
  --v=2
Restart=on-failure
RestartSec=5

[Install]
WantedBy=multi-user.target
```

### Restart API server
```bash
[vagrant@master provisoning_scripts]$ sudo systemctl daemon-reload
[vagrant@master provisoning_scripts]$ sudo systemctl restart kube-apiserver
```

### Verify
```bash
[vagrant@master provisoning_scripts]$ ./08-07-verify.sh
NAME                 STATUS    MESSAGE             ERROR
scheduler            Healthy   ok
controller-manager   Healthy   ok
etcd-0               Healthy   {"health":"true"}
HTTP/1.1 200 OK
Server: nginx
Date: Wed, 05 Aug 2020 16:23:58 GMT
Content-Type: text/plain; charset=utf-8
Content-Length: 2
Connection: keep-alive
Cache-Control: no-cache, private
X-Content-Type-Options: nosniff

ok{
  "major": "1",
  "minor": "18",
  "gitVersion": "v1.18.6",
  "gitCommit": "dff82dc0de47299ab66c83c626e08b245ab19037",
  "gitTreeState": "clean",
  "buildDate": "2020-07-15T16:51:04Z",
  "goVersion": "go1.13.9",
  "compiler": "gc",
  "platform": "linux/amd64"
```

## Re-configure calico
### Configure calico
```bash
$ kubectl edit secret calico-etcd-secrets -n kube-system
```

And override three keys:

- etcd-key
- etcd-cert
- etcd-ca

with

- `cat kubernetes-key.pem | base64 -w 0`
- `cat kubernetes.pem | base64 -w 0`
- `cat ca.pem | base64 -w 0`

And save it.


### Restart calico
```bash
[vagrant@master provisoning_scripts]$ kubectl delete pod -n kube-system $(kubectl get pods -l k8s-app=calico-kube-controllers -n kube-system -o jsonpath="{.items[0].metadata.name}")
```

```bash
[h3poteto@atami scripts]$ ./11-02-verify-worker.sh
NAME     STATUS   ROLES    AGE    VERSION
node-0   Ready    <none>   3d2h   v1.18.6
node-1   Ready    <none>   3d2h   v1.18.6
Connection to 127.0.0.1 closed.
```

Finished!!
