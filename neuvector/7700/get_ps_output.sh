kubectl exec -ti -nneuvector neuvector-controller-pod-5d5d456454-krz9q -- sh -c "ps aux > ps-op"
kubectl cp -nneuvector neuvector-controller-pod-5d5d456454-krz9q:ps-op ps-op
cat ps-op
