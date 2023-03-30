_DATE_=`date +%Y%m%d_%H%M%S`
if [ ! -d json ]; then
  mkdir json
fi
if [ ! -d logs/$_DATE_/ctr ]; then
  mkdir -p logs/$_DATE_/ctr
fi

for i in {4..79}
do

    cp  nv_511_n1.yaml nv_511_n${i}.yaml
    sed -i "s/neuvector-1/neuvector-${i}/" nv_511_n${i}.yaml
    kubectl create namespace neuvector-$i
    kubectl apply -f nv_511_n${i}.yaml
    sleep 10
    COUNT=0
    pod_name=`kubectl get pod -nneuvector-${i} -l app=neuvector-controller-pod -o jsonpath='{.items[0].metadata.name}'`
    pod_status=`kubectl get pod -n neuvector-${i} $pod_name -o=jsonpath='{.status.containerStatuses[].ready}'`
    while [ $pod_status != true ]
    do
	    echo "pod is not ready yet"
	    pod_status=`kubectl get pod -n neuvector-${i} $pod_name -o=jsonpath='{.status.containerStatuses[].ready}'`
            sleep 2
    done

    _RESTAPINPSVC_=`kubectl get svc -n neuvector-${i} | grep 10443 |grep -v fed|grep NodePort | awk '{print $1}'`
    _RESTAPIPORT_=`kubectl get svc -n neuvector-${i}  $_RESTAPINPSVC_ -o jsonpath='{.spec.ports[].nodePort}'`
    _FEDWORKERNPSVC_=`kubectl get svc -n neuvector-${i} | grep 10443 |grep  fed-worker|grep NodePort | awk '{print $1}'`
    _FEDWORKERNPPORT_=`kubectl get svc -n neuvector-${i}  $_FEDWORKERNPSVC_ -o jsonpath='{.spec.ports[].nodePort}'`
    _WORKERIP_="10.1.5.60"
    _WORKERNAME_=cluster.worker.60-n${i}
    _controllerIP_=`kubectl get pod -nneuvector-${i}  -l app=neuvector-controller-pod -o jsonpath='{.items[0].status.podIP}'`
    port=10443
    pass=admin
    #### get join token
    _PRIPORT_=32020
    _PRIIP_=10.1.7.171
    
    curl -k -H "Content-Type: application/json" -d '{"password": {"username": "admin", "password": '\"$pass\"'}}' "https://$_PRIIP_:$_PRIPORT_/v1/auth" > /dev/null 2>&1 > json/token.json
    _TOKEN_=`cat json/token.json | jq -r '.token.token'`
    curl -k -H "Content-Type: application/json" -H "X-Auth-Token: $_TOKEN_" "https://$_PRIIP_:$_PRIPORT_/v1/fed/join_token?token_duration=600" > json/jointoken.json   
    _JOINTOKEN_=`cat json/jointoken.json | jq -r '.join_token'`

    #### primary IP and fed port
    _PRIFEDPORT_=32141

    curl -k -H "Content-Type: application/json" -d '{"password": {"username": "admin", "password": '\"$pass\"'}}' "https://$_controllerIP_:$port/v1/auth" > /dev/null 2>&1 > json/token.json
    _TOKEN_=`cat json/token.json | jq -r '.token.token'`
    while [ -z "$_TOKEN_" ]; do
	    curl -k -H "Content-Type: application/json" -d '{"password": {"username": "admin", "password": '\"$pass\"'}}' "https://$_controllerIP_:$port/v1/auth" > /dev/null 2>&1 > json/token.json
            _TOKEN_=`cat json/token.json | jq -r '.token.token'`
	    sleep 10
	    echo "RESTAPI is not ready yet"
    done
    curl -k -H "Content-Type: application/json" -H "X-Auth-Token: $_TOKEN_"  -d  '{"force": true}' "https://$_controllerIP_:$port/v1/fed/leave"
    sleep 10
    curl -k -H "Content-Type: application/json" -H "X-Auth-Token: $_TOKEN_"  -d   '{"join_token": '\"$_JOINTOKEN_\"', "joint_rest_info": {"port": '$_FEDWORKERNPPORT_', "server": '\"$_WORKERIP_\"'}, "use_proxy": "", "server": '\"$_PRIIP_\"' , "port": '$_PRIFEDPORT_', "name": '\"$_WORKERNAME_\"'}' "https://$_controllerIP_:$port/v1/fed/join"
done
