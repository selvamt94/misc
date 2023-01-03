#if [ $# = "0" ];then
#     echo $0 enforcer_pod name list
#     echo example
#     echo $0 neuvector-enforcer-pod-kxlnh neuvector-enforcer-pod-xrqz5
#     exit
#fi


_DATE_=`date +%Y%m%d_%H%M%S`
if [ ! -d json ]; then
  mkdir json
fi
if [ ! -d logs/$_DATE_/enf ]; then
  mkdir -p logs/$_DATE_/enf
fi

port=10443
_controllerIP_=`kubectl get pod --all-namespaces -o wide | grep -m 1 neuvector-controller-pod |awk '{print $7}'`
_controllerIP_=`kubectl get pod -nneuvector -l app=neuvector-controller-pod -o jsonpath='{.items[0].status.podIP}'`
curl -k -H "Content-Type: application/json" -d '{"password": {"username": "admin", "password": "admin"}}' "https://$_controllerIP_:$port/v1/auth"   > /dev/null 2>&1 > json/token.json
_TOKEN_=`cat json/token.json | jq -r '.token.token'`

#_controllerIP_=`svc.sh | grep controller-debug | awk '{print $5}'`
#enf_pods=(`kubectl top pod -n neuvector | grep enforcer | grep -P '\d\d\d\d+m'| head -n 5`)
#enf_pods=(`kubectl top pod -n neuvector | grep enforcer | grep -P '\d\d+m'| head -n 5|awk '{print $1}'`)
enf_pods=(`kubectl top pod -n neuvector --sort-by=cpu | grep enforce |head -n 5|awk '{print $1}'`)

#enf_pods=$@

for pod in ${enf_pods[@]}
do 
        _ENF_IDS_+=(`cat json/enforcers.json | jq -r ".enforcers[] | select(.display_name == (\"$pod\"))|.id"`)

done

echo "disabling protect mode"

sleep 1
for id in ${_ENF_IDS_[@]}
do
        echo "disabling protect mode  enforcer $id"
        pod=`cat json/enforcers.json | jq -r ".enforcers[] | select(.id == \"$id\") |.display_name"`
        enf_id=`echo $pod | cut -d "-" -f 4`
        curl -X PATCH  -k -H "Content-Type: application/json" -H "X-Auth-Token: $_TOKEN_" -d '{"config": {"disable_nvprotect": true}}' "https://$_controllerIP_:$port/v1/enforcer/$id"   >/dev/null 2>&1 > logs/$_DATE_/enf/enf-${enf_id}_protect.json

done


echo "saving old profile files"

sleep 1
for pod in ${enf_pods[@]}
do
	echo "Removing old profile file of enforcer $pod"
	kubectl exec -ti -n neuvector $pod -- sh -c 'rm /var/neuvector/profile/*.prof' &> /dev/null
done
echo "capturing enforcer stats and counter"
sleep 1
for id in ${_ENF_IDS_[@]} 
do
	echo "capturing enforcer stats and counter  enforcer $id"
	pod=`cat json/enforcers.json | jq -r ".enforcers[] | select(.id == \"$id\") |.display_name"`
        enf_id=`echo $pod | cut -d "-" -f 4`
        curl  -k -H "Content-Type: application/json" -H "X-Auth-Token: $_TOKEN_"  "https://$_controllerIP_:$port/v1/enforcer/$id/stats"   >/dev/null 2>&1 > logs/$_DATE_/enf/enf-${enf_id}_stats.json
        curl  -k -H "Content-Type: application/json" -H "X-Auth-Token: $_TOKEN_"  "https://$_controllerIP_:$port/v1/enforcer/$id/counter"   >/dev/null 2>&1 > logs/$_DATE_/enf/enf-${enf_id}_counter.json

done
echo "capturing profile files"
sleep 1
for id in ${_ENF_IDS_[@]} 
do
	echo "Enabling profile for enforcer $id"
        curl -X POST -k -H "Content-Type: application/json" -H "X-Auth-Token: $_TOKEN_" -d '{"profiling": {"duration": 30, "methods": ["memory", "cpu"]}}' "https://$_controllerIP_:$port/v1/enforcer/$id/profiling"   >/dev/null 2>&1 > json/enf-profile.json

done

sleep 33

for pod in ${enf_pods[@]}
do
	echo "Saving profile data for enforcer $pod"
	kubectl cp -n neuvector $pod:var/neuvector/profile/enf.cpu.prof logs/$_DATE_/enf/enf.cpu.prof
	kubectl cp -n neuvector $pod:var/neuvector/profile/enf.goroutine.prof logs/$_DATE_/enf/enf.goroutine.prof
	kubectl cp -n neuvector $pod:var/neuvector/profile/enf.gc.memory.prof logs/$_DATE_/enf/enf.gc.memory.prof
	kubectl cp -n neuvector $pod:var/neuvector/profile/enf.memory.prof logs/$_DATE_/enf/enf.memory.prof
	id=`echo $pod | cut -d "-" -f 4`
	mv logs/$_DATE_/enf/enf.cpu.prof logs/$_DATE_/enf/enf.${id}.cpu.prof
	mv logs/$_DATE_/enf/enf.goroutine.prof logs/$_DATE_/enf/enf.goroutine.${id}.prof
	mv logs/$_DATE_/enf/enf.gc.memory.prof logs/$_DATE_/enf/enf.gc.memory.${id}.prof
	mv logs/$_DATE_/enf/enf.memory.prof logs/$_DATE_/enf/enf.${id}.memory.prof
done

echo "capturing ps aux output"
for pod in ${enf_pods[@]}
do
	echo "Saving ps aux output for enforcer $pod"
        id=`echo $pod | cut -d "-" -f 4`
	kubectl exec -ti -nneuvector $pod -- sh -c "ps aux > ps-output-enf-${id}"
        kubectl cp -n neuvector $pod:ps-output-enf-${id}  logs/$_DATE_/enf/ps-output-enf-${id}
done

echo "capturing top output"
for pod in ${enf_pods[@]}
do
        echo "Saving top output for enforcer $pod"
        id=`echo $pod | cut -d "-" -f 4`
        kubectl exec -ti -nneuvector $pod -- sh -c "top -b -n 10 -o %CPU | head -30 > top-output-enf-${id}"
        kubectl cp -n neuvector $pod:top-output-enf-${id}  logs/$_DATE_/enf/top-output-enf-${id}
done


kubectl top node > logs/$_DATE_/enf/node-top-output
kubectl top pod -nneuvector  > logs/$_DATE_/enf/neuvector-top-output



curl -k -H "Content-Type: application/json" -d '{"password": {"username": "admin", "password": "admin"}}' "https://$_controllerIP_:$port/v1/auth"   > /dev/null 2>&1 > json/token.json
_TOKEN_=`cat json/token.json | jq -r '.token.token'`

curl -k -H "Content-Type: application/json" -H "X-Auth-Token: $_TOKEN_" "https://$_controllerIP_:$port/v1/enforcer"  > /dev/null 2>&1  > json/enforcers.json
for pod in ${enf_pod_name[@]}
do 
        _ENF_IDS_+=(`cat json/enforcers.json | jq -r ".enforcers[] | select(.display_name == (\"$pod\"))|.id"`)

done
#_ENF_IDS_=`cat json/enforcers.json | jq -r .enforcers[1,2,3,4,5].id`

echo "Enabling enforcer debug log"

for id in  ${_ENF_IDS_[*]} ; do

   curl -X PATCH -k -H "Content-Type: application/json" -H "X-Auth-Token: $_TOKEN_" -d '{"config": {"debug": ["cpath"]}}' "https://$_controllerIP_:$port/v1/enforcer/$id"  > /dev/null 2>&1   > json/set_debug.json
sleep 1
done
sleep 1

for id in  ${_ENF_IDS_[*]} ; do
   echo "Enforcer id and debug status : $id"
   curl -k -H "Content-Type: application/json" -H "X-Auth-Token: $_TOKEN_" "https://$_controllerIP_:$port/v1/enforcer/$id/config"  > /dev/null 2>&1 > json/enf_config.json
   cat json/enf_config.json | jq .config.debug
done

sleep 10
echo "waiting 10seconds to collect debug log"
echo "Increase sleep seconds to collect log longer duration"

#enf_pods=`cat json/enforcers.json | jq -r .enforcers[1,2,3,4,5].display_name`

for pod in ${enf_pods[@]}
do
	echo "Saving debug log for enforcer $pod"

        id=`echo $pod | cut -d "-" -f 4`
        kubectl logs -n neuvector $pod |  grep -v "TLS handshake error" > logs/$_DATE_/enf/enf-${id}.log 
done

echo "Disabling Enforcer debug log"

for id in  ${_ENF_IDS_[*]} ; do
   echo "Disabling debug log for enforcer $id"
   curl -X PATCH -k -H "Content-Type: application/json" -H "X-Auth-Token: $_TOKEN_" -d '{"config": {"debug": [""]}}' "https://$_controllerIP_:$port/v1/enforcer/$id"  > /dev/null 2>&1   > json/set_debug.json
sleep 1
done
sleep 1

for id in  ${_ENF_IDS_[*]} ; do
   echo "Enforcer id and debug status : $id"
   curl -k -H "Content-Type: application/json" -H "X-Auth-Token: $_TOKEN_" "https://$_controllerIP_:$port/v1/enforcer/$id/config"  > /dev/null 2>&1 > json/enf_config.json
   cat json/enf_config.json | jq .config.debug
done

echo "enabling protect mode"

sleep 1
for id in ${ids[@]}
do
        echo "enabling protect mode enforcer $id"
        pod=`cat json/enforcers.json | jq -r ".enforcers[] | select(.id == \"$id\") |.display_name"`
        enf_id=`echo $pod | cut -d "-" -f 4`
        curl -X PATCH  -k -H "Content-Type: application/json" -H "X-Auth-Token: $_TOKEN_" -d '{"config": {"disable_nvprotect": false}}' "https://$_controllerIP_:$port/v1/enforcer/$id"   >/dev/null 2>&1 > logs/$_DATE_/enf/enf-${enf_id}_protect-e.json

done


echo "enabling protect mode"

sleep 1
for id in ${_ENF_IDS_[@]}
do
        echo "enabling protect mode  enforcer $id"
        pod=`cat json/enforcers.json | jq -r ".enforcers[] | select(.id == \"$id\") |.display_name"`
        enf_id=`echo $pod | cut -d "-" -f 4`
        curl -X PATCH  -k -H "Content-Type: application/json" -H "X-Auth-Token: $_TOKEN_" -d '{"config": {"disable_nvprotect": false}}' "https://$_controllerIP_:$port/v1/enforcer/$id"   >/dev/null 2>&1 > logs/$_DATE_/enf/enf-${enf_id}_protect.json

done
