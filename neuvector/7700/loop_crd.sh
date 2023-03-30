#!/bin/bash
#while true
#do	
     #for i in {121..13000}
     for i in {121..221}

     do
         	cp cr.BL.yaml yaml/cr-demo${i}.yaml
         	sed -i "s/namespace: demo/namespace: demo${i}/" yaml/cr-demo${i}.yaml
         	sed -i "s/pod.demo/pod.demo${i}/" yaml/cr-demo${i}.yaml
         	sed -i "s/value: demo/value: demo${i}/" yaml/cr-demo${i}.yaml
         #	sed -i "s/exploit/expoit${i}/" yaml/cr-demo${i}.yaml
         	sed -i -r "s|value: exploit([0-9]).demo|value: exploit\1.demo${i}|" yaml/cr-demo${i}.yaml
         	sed -i -r "s|name: nv.exploit([0-9]).demo|name: nv.exploit\1.demo${i}|" yaml/cr-demo${i}.yaml
         	kubectl create ns demo${i}
         	sleep 2
         	kubectl apply -f yaml/cr-demo${i}.yaml
         	cr_count=`kubectl get nvsecurityrule.neuvector.com -n demo${i} |grep -v NAME| wc -l`  
         	while [ $cr_count != "24" ]
         	do
         		cr_count=`kubectl get nvsecurityrule.neuvector.com -n demo${i} | wc -l`
         		echo "waiting for all CR to be created $cr_count"
         		sleep 1
         	done
         	sleep 60
		kubectl delete ns demo${i}
                sleep 600
     
     done
     
     #for i in {121..130}
     #do
     #        kubectl delete ns demo${i}
     #done
#done
