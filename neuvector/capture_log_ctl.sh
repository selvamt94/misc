#!/bin/bash 
_DATE_=`date +%Y%m%d_%H%M%S`
if [ ! -d json ]; then
  mkdir json
fi
if [ ! -d logs/$_DATE_/ctr ]; then
  mkdir -p logs/$_DATE_/ctr
fi

port=10443
_controllerIP_=`kubectl get pod --all-namespaces -o wide | grep -m 1 neuvector-controller-pod |awk '{print $7}'`
_controllerIP_=`kubectl get pod -nneuvector -l app=neuvector-controller-pod -o jsonpath='{.items[0].status.podIP}'`
#_controllerIP_=`svc.sh | grep controller-debug | awk '{print $5}'`

curl -k -H "Content-Type: application/json" -d '{"password": {"username": "admin", "password": "admin"}}' "https://$_controllerIP_:$port/v1/auth" > /dev/null 2>&1 > json/token.json
_TOKEN_=`cat json/token.json | jq -r '.token.token'`
curl -k -H "Content-Type: application/json" -H "X-Auth-Token: $_TOKEN_" "https://$_controllerIP_:$port/v1/controller" > /dev/null 2>&1  > json/controllers.json

ids=`cat json/controllers.json | jq -r .controllers[].id`

pods=`kubectl get pod -nneuvector -o wide| grep neuvector-controller-pod |awk '{print $1}'`
for pod in ${pods[@]}
do
	kubectl exec -ti -n neuvector $pod -- sh -c 'rm /var/neuvector/profile/*.prof' &> /dev/null
done
echo "capturing profile files"
for id in ${ids[@]} 
do
  curl -X POST -k -H "Content-Type: application/json" -H "X-Auth-Token: $_TOKEN_" -d '{"profiling": {"duration": 30, "methods": ["memory", "cpu"]}}' "https://$_controllerIP_:$port/v1/controller/$id/profiling"   >/dev/null 2>&1 > json/ctrl-profile.json

done

sleep 33

pods=`kubectl get pod -nneuvector -o wide| grep neuvector-controller-pod |awk '{print $1}'`

for pod in ${pods[@]}
do
	kubectl cp -n neuvector $pod:var/neuvector/profile/ctl.cpu.prof logs/$_DATE_/ctr/ctl.cpu.prof
	kubectl cp -n neuvector $pod:var/neuvector/profile/ctl.goroutine.prof logs/$_DATE_/ctr/ctl.goroutine.prof
	kubectl cp -n neuvector $pod:var/neuvector/profile/ctl.gc.memory.prof logs/$_DATE_/ctr/ctl.gc.memory.prof
	kubectl cp -n neuvector $pod:var/neuvector/profile/ctl.memory.prof logs/$_DATE_/ctr/ctl.memory.prof
	id=`echo $pod | cut -d "-" -f 5`
	mv logs/$_DATE_/ctr/ctl.cpu.prof logs/$_DATE_/ctr/ctl.${id}.cpu.prof
	mv logs/$_DATE_/ctr/ctl.goroutine.prof logs/$_DATE_/ctr/ctl.goroutine.${id}.prof
	mv logs/$_DATE_/ctr/ctl.gc.memory.prof logs/$_DATE_/ctr/ctl.gc.memory.${id}.prof
	mv logs/$_DATE_/ctr/ctl.memory.prof logs/$_DATE_/ctr/ctl.${id}.memory.prof
done

echo "capturing ps aux output"
for pod in ${pods[@]}
do
        id=`echo $pod | cut -d "-" -f 5`
	kubectl exec -ti -nneuvector $pod -- sh -c "ps aux > ps-output-ctrl-${id}"
        kubectl cp -n neuvector $pod:ps-output-ctrl-${id}  logs/$_DATE_/ctr/ps-output-ctrl-${id}
done

kubectl top node > logs/$_DATE_/ctr/node-top-output
kubectl top pod -nneuvector  > logs/$_DATE_/ctr/neuvector-top-output



#REST API to enable cpath conn debug on all clusters in the cluster
port=10443
_controllerIP_=`kubectl get pod --all-namespaces -o wide | grep -m 1 neuvector-controller-pod |awk '{print $7}'`
_controllerIP_=`kubectl get pod -nneuvector -l app=neuvector-controller-pod -o jsonpath='{.items[0].status.podIP}'`
curl -k -H "Content-Type: application/json" -d '{"password": {"username": "admin", "password": "admin"}}' "https://$_controllerIP_:$port/v1/auth"   > /dev/null 2>&1 > json/token.json
_TOKEN_=`cat json/token.json | jq -r '.token.token'`

curl -k -H "Content-Type: application/json" -H "X-Auth-Token: $_TOKEN_" "https://$_controllerIP_:$port/v1/controller"  > /dev/null 2>&1  > json/ctrls.json

_CTRLS_IDS_=`cat json/ctrls.json | jq -r .controllers[].id`

echo "Enabling controller debug log"

for id in  ${_CTRLS_IDS_[*]} ; do

   curl -X PATCH -k -H "Content-Type: application/json" -H "X-Auth-Token: $_TOKEN_" -d '{"config": {"debug": ["cpath"]}}' "https://$_controllerIP_:$port/v1/controller/$id"  > /dev/null 2>&1   > json/set_debug.json
sleep 1
done
sleep 1

for id in  ${_CTRLS_IDS_[*]} ; do
   echo "Controller id and debug status : $id"
   curl -k -H "Content-Type: application/json" -H "X-Auth-Token: $_TOKEN_" "https://$_controllerIP_:$port/v1/controller/$id/config"  > /dev/null 2>&1 > json/ctrl_config.json
   cat json/ctrl_config.json | jq .config.debug
done

sleep 10
echo "waiting 10seconds to collect debug log"
echo "Increase sleep seconds to collect log longer duration"

ctrl_pods=`kubectl get pod -nneuvector -o wide| grep neuvector-controller-pod |awk '{print $1}'`

for pod in ${ctrl_pods[@]}
do
        id=`echo $pod | cut -d "-" -f 5`
        kubectl logs -n neuvector $pod |  grep -v "TLS handshake error" > logs/$_DATE_/ctr/ctrl-${id}.log 
done

echo "Disabling controller debug log"

for id in  ${_CTRLS_IDS_[*]} ; do

   curl -X PATCH -k -H "Content-Type: application/json" -H "X-Auth-Token: $_TOKEN_" -d '{"config": {"debug": [""]}}' "https://$_controllerIP_:$port/v1/controller/$id"  > /dev/null 2>&1   > json/set_debug.json
sleep 1
done
sleep 1

for id in  ${_CTRLS_IDS_[*]} ; do
   echo "Controller id and debug status : $id"
   curl -k -H "Content-Type: application/json" -H "X-Auth-Token: $_TOKEN_" "https://$_controllerIP_:$port/v1/controller/$id/config"  > /dev/null 2>&1 > json/ctrl_config.json
   cat json/ctrl_config.json | jq .config.debug
done


port=10443
### Find leader controller
_controllerIP_=`kubectl get pod -nneuvector -l app=neuvector-controller-pod -o jsonpath='{.items[0].status.podIP}'`
port=10443
curl -k -H "Content-Type: application/json" -d '{"password": {"username": "admin", "password": "admin"}}' "https://$_controllerIP_:$port/v1/auth" > /dev/null 2>&1 > json/token.json
_TOKEN_=`cat json/token.json | jq -r '.token.token'`
curl -k -H "Content-Type: application/json" -H "X-Auth-Token: $_TOKEN_" "https://$_controllerIP_:$port/v1/controller" > /dev/null 2>&1  > json/controllers.json
leader_pod=`cat json/controllers.json | jq -r '."controllers"[] | select(.leader==true) | .display_name'`
echo $leader_pod

echo "saving kv snapshot"
kubectl exec -ti -nneuvector $leader_pod -- rm root/backup.snap &> /dev/null

kubectl exec -ti -nneuvector $leader_pod -- consul kv get -stale -recurse -separator="" -keys / > logs/$_DATE_/ctr/dump_keys

echo "coping kv snapshot local machine"
kubectl exec -ti -nneuvector $leader_pod -- consul snapshot save -stale backup.snap

kubectl exec -ti -nneuvector $leader_pod -- consul snapshot inspect -kvdetails -kvdepth 10 backup.snap > logs/$_DATE_/ctr/res.log

kubectl exec -ti -nneuvector $leader_pod -- ls -l

kubectl cp -n neuvector $leader_pod:backup.snap logs/$_DATE_/ctr/backup.snap

