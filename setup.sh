aws s3 cp s3://simplrinfrabucket/eks/cluster.yaml .
aws s3 cp s3://simplrinfrabucket/vpc/cf_template_master.yaml .
aws s3 cp s3://simplrinfrabucket/vpc/parameters.json  .


aws cloudformation create-stack --stack-name rolesinfra --region us-east-2 --template-body file://infra/roles.yaml --capabilities  CAPABILITY_IAM  CAPABILITY_NAMED_IAM  CAPABILITY_AUTO_EXPAND

 aws cloudformation wait stack-create-complete --region us-east-2 --stack-name rolesinfra

aws cloudformation create-stack --stack-name nlbinfra --region us-east-2 --template-body file://infra/nlb-infra.yaml --capabilities  CAPABILITY_IAM  CAPABILITY_NAMED_IAM  CAPABILITY_AUTO_EXPAND

 aws cloudformation wait stack-create-complete --region us-east-2 --stack-name nlbinfra 


aws cloudformation create-stack --stack-name --region us-east-2 simpplrnwstack --template-body file://cf_template_master.yaml --parameters file://parameters.json --capabilities  CAPABILITY_IAM  CAPABILITY_NAMED_IAM  CAPABILITY_AUTO_EXPAND

aws cloudformation wait stack-create-complete --region us-east-2 --stack-name simpplrnwstack 

aws cloudformation --region us-east-2 list-exports

sleep 10
./variables.sh

eksctl create cluster -f cluster.yaml

#  kubectl apply -f https://raw.githubusercontent.com/kubernetes-sigs/aws-alb-ingress-controller/v1.1.4/docs/examples/rbac-role.yaml #RBAC Role for alb ingress

#  kubectl apply -f ./ingress-controller/alb-ingress-controller.yaml

#Following will be done with 
# kubectl create namespace preprod  
# kubectl apply -f ./ingress-controller/alb-ingress-controller.yaml
#  kubectl apply -f ./accesscontrol # For access control
#  kubectl apply -f./Frontend
#  kubectl apply -f./Backend
#  kubectl apply -f ./ingress-controller/ingress.yaml
# aws cloudformation create-stack --stack-name simplr-nlb-alb --region us-east-2 --template-body file://infra/nlb-alb.yaml --capabilities  CAPABILITY_IAM  CAPABILITY_NAMED_IAM  CAPABILITY_AUTO_EXPAND
#  aws cloudformation wait stack-create-complete --region us-east-2 --stack-name simplr-nlb-alb 



