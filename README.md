# vagrant

To bring the services to life at ista in VPN environment, you need to add a new VBox private Network first and disable the network running in range 172.16.0.0/12.  This network is used for french servers.

The kubernetes-cluster vagrant provisioning creates a Kubernetes cluster with 1 admin node (kadmin) and 2 worker nodes (kworker 1 and 2). The machines will always get the same IP addresses - but you need to check your private VBox network what IP range it would be. Then add it to your /etc/hosts file.

The nfs-server is a profile that creates an nfs-server that can be used for persistant storage in the kubernetes cluster using the nfs-provisioner.

The passwords are


| User    |  Password   |
|---------|-------------|
| root    | kubeadmin   |  
| vagrant | vagrant     |


# Kubernetes worker labeling

To ensure that the K8S cluster works correctly, label the worker nodes as worker nodes.

```sh
kubectl label node kworker1 node-role.kubernetes.io/worker=worker
kubectl label node kworker2 node-role.kubernetes.io/worker=worker
kubectl label node kworker3 node-role.kubernetes.io/worker=worker
```
