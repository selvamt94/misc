kubectl create -f https://docs.projectcalico.org/manifests/tigera-operator.yaml
sleep 10
kubectl create -f https://docs.projectcalico.org/manifests/custom-resources.yaml
watch kubectl get pods -n calico-system
kubectl get nodes -o wide



