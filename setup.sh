aws s3 cp s3://smtip-artifact-bucket/eks/cluster.yaml .
aws s3 cp s3://smtip-artifact-bucket/vpc/cf_template_master.yaml .
aws s3 cp s3://smtip-artifact-bucket/vpc/parameters.json  .


aws cloudformation create-stack --stack-name $2 --region $1  --template-body file://cf_template_master.yaml --parameters file://parameters.json --capabilities  CAPABILITY_IAM  CAPABILITY_NAMED_IAM  CAPABILITY_AUTO_EXPAND

aws cloudformation wait stack-create-complete --region $1 --stack-name $2 

aws cloudformation create-stack --stack-name $3 --region $1 --template-body file://infra/roles.yaml --parameters file://infra/parameters.json --capabilities  CAPABILITY_IAM  CAPABILITY_NAMED_IAM  CAPABILITY_AUTO_EXPAND

aws cloudformation wait stack-create-complete --region $1 --stack-name $3

sleep 10

sed -i "s|REGION1|$1|" variables.sh
sed -i "s|REGION1|$1|" cluster.yaml
sed -i "s|ROLE_STACK|$3|" variables.sh
sed -i "s|NETWORK_STACK|$2|" variables.sh
sed -i "s|NETWORK_STACK|$2|" ./services/servicesparams.json





# aws cloudformation create-stack --stack-name nlbinfra --region us-east-2 --template-body file://infra/nlb-infra.yaml --parameters file://infra/parameters.json --capabilities CAPABILITY_IAM  CAPABILITY_NAMED_IAM  CAPABILITY_AUTO_EXPAND

#  aws cloudformation wait stack-create-complete --region us-east-2 --stack-name nlbinfra 

./variables.sh 

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



