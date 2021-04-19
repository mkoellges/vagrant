#!/bin/bash

echo "[TASK 1] Join node to Kubernetes Cluster"
apt install -qq -y sshpass
sshpass -p "kubeadmin" scp -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no kmaster.example.com:/joincluster.sh /joincluster.sh 
bash /joincluster.sh
