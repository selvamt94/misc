cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF

sudo modprobe overlay
sudo modprobe br_netfilter

# sysctl params required by setup, params persist across reboots
cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-iptables  = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward                 = 1
EOF

# Apply sysctl params without reboot
sudo sysctl --system

sudo apt-get update && sudo apt-get install -y apt-transport-https curl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
cat <<EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF
sudo apt-get update -y
sudo apt-get install -y kubelet kubeadm kubectl selinux-utils
sudo setenforce 0
sudo sed -i '0,/^exit.*/s/^exit.*/swapoff -a\n&/' /etc/rc.local
sudo reboot

############# Kubernetes 1.24 #####################

git clone https://github.com/Mirantis/cri-dockerd.git
cd cri-dockerd/
mkdir bin
sudo apt install golang-go
cd src && go get && go build -o ../bin/cri-dockerd
To install, on a Linux system that uses systemd, and already has Docker Engine installed

# Run these commands as root
mkdir -p /usr/local/bin
sudo cp bin/cri-dockerd /usr/local/bin/cri-dockerd
sudo chmod 0755  /usr/local/bin/cri-dockerd
sudo chown -R root:root /usr/local/bin/cri-dockerd
cd ../
sudo cp -a packaging/systemd/* /etc/systemd/system
sudo sed -i -e 's,/usr/bin/cri-dockerd,/usr/local/bin/cri-dockerd,' /etc/systemd/system/cri-docker.service
sudo systemctl daemon-reload
sudo systemctl enable cri-docker.service
sudo systemctl enable --now cri-docker.socket
=======================================================

#################### containerd #############
wget https://github.com/containerd/containerd/releases/download/v1.6.4/containerd-1.6.4-linux-amd64.tar.gz
sudo tar Cxzvf /usr/local containerd-1.6.4-linux-amd64.tar.gz
wget https://raw.githubusercontent.com/containerd/containerd/main/containerd.service
sudo mkdir -p /usr/local/lib/systemd/system/
sudo cp containerd.service /usr/local/lib/systemd/system/
wget https://github.com/opencontainers/runc/releases/download/v1.1.2/runc.amd64
sudo install -m 755 runc.amd64 /usr/local/sbin/runc
wget https://github.com/containernetworking/plugins/releases/download/v1.1.1/cni-plugins-linux-amd64-v1.1.1.tgz
sudo mkdir -p /opt/cni/bin
sudo tar Cxzvf /opt/cni/bin cni-plugins-linux-amd64-v1.1.1.tgz
sudo systemctl daemon-reload
sudo systemctl enable --now containerd
sudo mkdir /etc/containerd/
sudo containerd config default > /etc/containerd/config.toml
sudo sed -i 's/SystemdCgroup = false/SystemdCgroup = true/' /etc/containerd/config.toml



sudo cp /usr/bin/kubeadm /usr/local/bin
sudo cp /usr/bin/kubelet /usr/local/bin
sudo cp /usr/bin/kubectl /usr/local/bin
kubeadm join 10.1.7.101:6443 --cri-socket /run/containerd/containerd.sock --token dsrct5.lv6v6e09nojiq2hc \
        --discovery-token-ca-cert-hash sha256:b550f2baf4968efa4f535aa51a369d893af8bc7add18c1c19934246c799115b4 
