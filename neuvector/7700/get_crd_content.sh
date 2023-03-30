pod=`kubectl get pod -nneuvector  | grep controller | sed -n 2p | awk '{print $1}'`

kubectl exec -ti $pod -nneuvector -- consul kv export crdcontent > crd_event.json
