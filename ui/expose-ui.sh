kubectl port-forward --namespace donkey-koin $(kubectl get po -n donkey-koin | grep ui | awk '{print $1;}') 80:80