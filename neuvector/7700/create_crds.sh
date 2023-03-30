for i in {1..6}
do
	cp cr.BL.org cr$i.yaml
	sed -i "s/exploit/exploit$i/" cr$i.yaml
        sed -i "s/nginx-pod/nginx$i-pod/" cr$i.yaml
        sed -i "s/name: nginx/name: nginx$i/" cr$i.yaml
        sed -i "s/node-pod/node$i-pod/" cr$i.yaml
        sed -i "s/name: node/name: node$i/" cr$i.yaml
        sed -i "s/redis-pod/redis$i-pod/" cr$i.yaml
        sed -i "s/name: redis/name: redis$i/" cr$i.yaml
	kubectl apply -f cr$i.yaml
	#kubectl delete -f cr$i.yaml
done
