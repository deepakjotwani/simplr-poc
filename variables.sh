#!/bin/bash
export CLUSTER_ROLE_ARN="$(aws cloudformation --region REGION1 list-exports  | jq '.Exports[] | select(.Name == "ROLE_STACK-ClusterRoleARN") | .Value' | tr -d \'\")" 
sed -i "s|CLUSTER_ROLE_ARN|${CLUSTER_ROLE_ARN}|" cluster.yaml
export NODEGROUP_ROLE_ARN="$(aws cloudformation --region REGION1 list-exports  | jq '.Exports[] | select(.Name == "ROLE_STACK-NodeGroupRoleARN") | .Value' | tr -d \'\")" 
sed -i "s|NODEGROUP_ROLE_ARN|${NODEGROUP_ROLE_ARN}|" cluster.yaml
export INSTANCE_PROFILE_ARN="$(aws cloudformation --region REGION1 list-exports  | jq '.Exports[] | select(.Name == "ROLE_STACK-NodeGroupInstanceProfileARN") | .Value' | tr -d \'\")" 
sed -i "s|INSTANCE_PROFILE_ARN|${INSTANCE_PROFILE_ARN}|" cluster.yaml


export VPC_ID="$(aws cloudformation --region REGION1 list-exports  | jq '.Exports[] | select(.Name == "NETWORK_STACK:vpc:id") | .Value'  | tr -d \'\")"
sed -i "s|VPC_ID|${VPC_ID}|" cluster.yaml
sed -i "s|VPC_ID|${VPC_ID}|" ./services/servicesparams.json
sed -i "s|VPC_ID|${VPC_ID}|" ./ingress-controller/alb-ingress-controller.yaml


export AZ1="$(aws cloudformation --region REGION1 list-exports  | jq '.Exports[] | select(.Name == "'$VPC_ID':availability-zone-1:id") | .Value'  | tr -d \'\")"
sed -i "s|AZ1|${AZ1}|" cluster.yaml

export AZ2="$(aws cloudformation --region REGION1 list-exports  | jq '.Exports[] | select(.Name == "'$VPC_ID':availability-zone-2:id") | .Value'  | tr -d \'\")"
sed -i "s|AZ2|${AZ2}|" cluster.yaml
export AZ3="$(aws cloudformation --region REGION1 list-exports  | jq '.Exports[] | select(.Name == "'$VPC_ID':availability-zone-3:id") | .Value'  | tr -d \'\")"
sed -i "s|AZ3|${AZ3}|" cluster.yaml
                 
export PRIVATE_SUBNET_IDS="$(aws cloudformation --region REGION1 list-exports  | jq '.Exports[] | select(.Name == "'$VPC_ID':private-subnet:ids") | .Value' | tr -d \'\")"

export SUBNET1="$(echo $PRIVATE_SUBNET_IDS |  cut -d',' -f1)"
sed -i "s|SUBNET1|${SUBNET1}|" cluster.yaml

export SUBNET2="$(echo $PRIVATE_SUBNET_IDS |  cut -d',' -f2)"
sed -i "s|SUBNET2|${SUBNET2}|" cluster.yaml

export SUBNET3="$(echo $PRIVATE_SUBNET_IDS |  cut -d',' -f3)"
sed -i "s|SUBNET3|${SUBNET3}|" cluster.yaml

export ENV="$(cat clustervalues.json  | jq '.Exports[] | select(.Name == "enviroment") | .Value'  | tr -d \'\")"
sed -i "s|ENV|${ENV}|" cluster.yaml 
sed -i "s|ENV|${ENV}|" ./ingress-controller/alb-ingress-controller.yaml

export MIN_SIZE="$(cat clustervalues.json  | jq '.Exports[] | select(.Name == "minimumsize") | .Value'  | tr -d \'\")"
sed -i "s|MIN_SIZE|${MIN_SIZE}|" cluster.yaml

export MAX_SIZE="$(cat clustervalues.json  | jq '.Exports[] | select(.Name == "maximumsize") | .Value'  | tr -d \'\")"
sed -i "s|MAX_SIZE|${MAX_SIZE}|" cluster.yaml

export DESIRED_CAPACITY="$(cat clustervalues.json  | jq '.Exports[] | select(.Name == "desiredcapacity") | .Value'  | tr -d \'\")"
sed -i "s|DESIRED_CAPACITY|${DESIRED_CAPACITY}|" cluster.yaml


export INSTANCE_TYPE="$(cat clustervalues.json  | jq '.Exports[] | select(.Name == "instancetype") | .Value'  | tr -d \'\")"
sed -i "s|INSTANCE_TYPE|${INSTANCE_TYPE}|" cluster.yaml
















