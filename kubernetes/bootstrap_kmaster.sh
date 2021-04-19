#!/bin/bash

echo "[TASK 1] Pull required containers"
kubeadm config images pull

echo "[TASK 2] Initialize Kubernetes Cluster"
# kubeadm init --apiserver-advertise-address=10.37.129.100 --pod-network-cidr=192.168.0.0/16 >> /root/kubeinit.log 2>/dev/null
kubeadm init --cri-socket /run/containerd/containerd.sock --apiserver-advertise-address 10.37.129.100 --pod-network-cidr=192.168.0.0/16

echo "[TASK 3] Deploy Calico network"
kubectl --kubeconfig=/etc/kubernetes/admin.conf create -f https://docs.projectcalico.org/v3.16/manifests/calico.yaml

echo "[TASK 4] Generate and save cluster join command to /joincluster.sh"
kubeadm token create --print-join-command > /joincluster.sh
sed -i 's/--token/--cri-socket \/run\/containerd\/containerd.sock --token/' /joincluster.sh
