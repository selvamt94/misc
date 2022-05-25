sudo apt-get update && sudo apt-get install -y apt-transport-https curl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
cat <<EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF
sudo apt-get update -y
sudo apt-get install -y kubelet kubeadm kubectl selinux-utils
sudo setenforce 0
sudo sed -i '0,/^exit.*/s/^exit.*/swapoff -a\n&/' /etc/rc.local
sudo sed -i '$i swapoff -a\n\nexit 0' /etc/rc.local
sudo reboot
sudo apt-mark hold kubelet kubeadm kubectl


############# Kubernetes 1.24 #####################

git clone https://github.com/Mirantis/cri-dockerd.git
cd cri-dockerd/
mkdir bin
cd src && go get && go build -o ../bin/cri-dockerd
To install, on a Linux system that uses systemd, and already has Docker Engine installed

# Run these commands as root
mkdir -p /usr/local/bin
sudo cp bin/cri-dockerd /usr/local/bin/cri-dockerd
sudo chmod 0755  /usr/local/bin/cri-dockerd
sudo chown -R root:root /usr/local/bin/cri-dockerd
cp -a packaging/systemd/* /etc/systemd/system
sed -i -e 's,/usr/bin/cri-dockerd,/usr/local/bin/cri-dockerd,' /etc/systemd/system/cri-docker.service
systemctl daemon-reload
systemctl enable cri-docker.service
systemctl enable --now cri-docker.socket

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



sudo kubeadm init --pod-network-cidr=192.168.0.0/16 --cri-socket /run/containerd/containerd.sock
#sudo kubeadm init --pod-network-cidr=192.168.0.0/16 --cri-socket /run/cri-dockerd.sock
mkdir -p $HOME/.kube
sudo cp  /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
kubectl create -f https://docs.projectcalico.org/manifests/tigera-operator.yaml
sleep 10
kubectl create -f https://docs.projectcalico.org/manifests/custom-resources.yaml
watch kubectl get pods -n calico-system
kubectl get nodes -o wide

