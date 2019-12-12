
kubectl delete -f ./Backend
kubectl delete -f ./Frontend
kubectl delete -f ./ingress-controller
eksctl delete cluster -f cluster.yaml