#!/bin/bash

aws s3 cp s3://smtip-artifacts-preprod/eks/cluster.yaml .
aws s3 cp s3://smtip-artifacts-preprod/vpc/cf_template_master.yaml .
aws s3 cp s3://smtip-artifacts-preprod/vpc/parameters.json  .


aws cloudformation create-stack --stack-name $2 --region $1  --template-body file://cf_template_master.yaml --parameters file://parameters.json --capabilities  CAPABILITY_IAM  CAPABILITY_NAMED_IAM  CAPABILITY_AUTO_EXPAND

aws cloudformation wait stack-create-complete --region $1 --stack-name $2

aws cloudformation create-stack --stack-name $3 --region $1 --template-body file://infra/roles.yaml --parameters file://infra/parameters.json --capabilities  CAPABILITY_IAM  CAPABILITY_NAMED_IAM  CAPABILITY_AUTO_EXPAND

aws cloudformation wait stack-create-complete --region $1 --stack-name $3

sleep 10

sed -i "s|REGION1|$1|" variables.sh
sed -i "s|REGION1|$1|" cluster.yaml
sed -i "s|REGION1|$1|" ./ingress-controller/alb-ingress-controller.yaml

sed -i "s|ROLE_STACK|$3|" variables.sh
sed -i "s|ROLE_STACK|$3|" ./services/servicesparams.json
sed -i "s|NETWORK_STACK|$2|" variables.sh
sed -i "s|NETWORK_STACK|$2|" ./services/servicesparams.json
sed -i "s|NLB_STACK|$4|" ./services/servicesparams.json
sed -i "s|APIGATEWAY_STACK|$5|" ./services/servicesparams.json

./variables.sh

aws cloudformation create-stack --stack-name $4 --region $1 --template-body file://services/nlb.yaml --parameters file://services/servicesparams.json --capabilities CAPABILITY_IAM  CAPABILITY_NAMED_IAM  CAPABILITY_AUTO_EXPAND

 aws cloudformation wait stack-create-complete --region $1 --stack-name $4


 aws cloudformation create-stack --stack-name $5 --region $1 --template-body file://services/apigateway.yaml --parameters file://services/servicesparams.json --capabilities CAPABILITY_IAM  CAPABILITY_NAMED_IAM  CAPABILITY_AUTO_EXPAND

  aws cloudformation wait stack-create-complete --region $1 --stack-name $5

# eksctl create cluster -f cluster.yaml

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
