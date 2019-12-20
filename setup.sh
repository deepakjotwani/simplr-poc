
aws cloudformation create-stack --stack-name rolesinfra --region us-east-2 --template-body file://infra/roles.yaml --capabilities  CAPABILITY_IAM  CAPABILITY_NAMED_IAM  CAPABILITY_AUTO_EXPAND

aws cloudformation create-stack --stack-name nlbinfra --region us-east-2 --template-body file://infra/nlb-infra.yaml --capabilities  CAPABILITY_IAM  CAPABILITY_NAMED_IAM  CAPABILITY_AUTO_EXPAND

sleep 10m

./variables.sh

eksctl create cluster -f cluster.yaml

# aws cloudformation create-stack --stack-name simplr-nlb-alb --region us-east-2 --template-body file://infra/nlb-alb.json --capabilities  CAPABILITY_IAM  CAPABILITY_NAMED_IAM  CAPABILITY_AUTO_EXPAND





kubectl apply -f https://raw.githubusercontent.com/kubernetes-sigs/aws-alb-ingress-controller/v1.1.4/docs/examples/rbac-role.yaml
  
kubectl apply -f ./ingress-controller/alb-ingress-controller.yaml

#  kubectl apply -f ./accesscontrol
# kubectl apply -f./Frontend
# kubectl apply -f./Backend
# kubectl apply -f ./ingress-controller/ingress.yaml


