#!/bin/bash -e

for namespace in $(kubectl get namespaces -A -o=jsonpath="{.items[*]['metadata.name']}"); do
  echo -n "Patching namespace $namespace "
  cp .dns.yaml dns.yaml
  sed -i "s/namespace1/${namespace}/" dns.yaml
  kubectl apply -f dns.yaml
done
