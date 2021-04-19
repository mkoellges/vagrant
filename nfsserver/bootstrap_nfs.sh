#filename=bootstrap_nfs.sh

# Update hosts file
echo "[TASK 10] Update /etc/hosts file"
cat >>/etc/hosts<<EOF
10.37.129.100   kmaster.example.com     kmaster
10.37.129.101   kworker1.example.com    kworker1
10.37.129.102   kworker2.example.com    kworker2
10.37.129.103   nfs-server.example.com  nfs-server
EOF

echo "[TASK 2] Download and install NFS server"
apt-get update
apt install -y nfs-kernel-server

echo "[TASK 3] Create a kubedata directory"
mkdir -p /srv/nfs/kubedata

echo "[TASK 4] Update the shared folder access"
chmod -R 777 /srv/nfs/kubedata
chown nobody:nogroup /srv/nfs/kubedata

echo "[TASK 5] Make the kubedata directory available on the network"
cat >>/etc/exports<<EOF
/srv/nfs/kubedata    *(rw,sync,no_subtree_check,no_root_squash,no_all_squash,insecure)
EOF

echo "[TASK 6] Export the updates"
exportfs -a

echo "[TASK 7] Enable NFS Server"
systemctl enable nfs-kernel-server

echo "[TASK 8] Start NFS Server"
systemctl start nfs-kernel-server
