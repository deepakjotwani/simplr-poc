#!/bin/sh 
export CLUSTER_ROLE_ARN="$(aws cloudformation --region us-east-2 list-exports  | jq '.Exports[] | select(.Name == "'$2'-ClusterRoleARN") | .Value' | tr -d \'\")" 
sed -i "s|CLUSTER_ROLE_ARN|${CLUSTER_ROLE_ARN}|" cluster.yaml
export NODEGROUP_ROLE_ARN="$(aws cloudformation --region us-east-2 list-exports  | jq '.Exports[] | select(.Name == "'$2'-NodeGroupRoleARN") | .Value' | tr -d \'\")" 
sed -i "s|NODEGROUP_ROLE_ARN|${NODEGROUP_ROLE_ARN}|" cluster.yaml
export INSTANCE_PROFILE_ARN="$(aws cloudformation --region us-east-2 list-exports  | jq '.Exports[] | select(.Name == "'$2'-NodeGroupInstanceProfileARN") | .Value' | tr -d \'\")" 
sed -i "s|INSTANCE_PROFILE_ARN|${INSTANCE_PROFILE_ARN}|" cluster.yaml


export VPC_ID="$(aws cloudformation --region us-east-2 list-exports  | jq '.Exports[] | select(.Name == "'$1':vpc:id") | .Value'  | tr -d \'\")"
sed -i "s|VPC_ID|${VPC_ID}|" cluster.yaml

export AZ1="$(aws cloudformation --region us-east-2 list-exports  | jq '.Exports[] | select(.Name == "'$VPC_ID':availability-zone-1:id") | .Value'  | tr -d \'\")"
sed -i "s|AZ1|${AZ1}|" cluster.yaml

export AZ2="$(aws cloudformation --region us-east-2 list-exports  | jq '.Exports[] | select(.Name == "'$VPC_ID':availability-zone-2:id") | .Value'  | tr -d \'\")"
sed -i "s|AZ2|${AZ2}|" cluster.yaml
export AZ3="$(aws cloudformation --region us-east-2 list-exports  | jq '.Exports[] | select(.Name == "'$VPC_ID':availability-zone-3:id") | .Value'  | tr -d \'\")"
sed -i "s|AZ3|${AZ3}|" cluster.yaml
                 
export PRIVATE_SUBNET_IDS="$(aws cloudformation --region us-east-2 list-exports  | jq '.Exports[] | select(.Name == "'$VPC_ID':private-subnet:ids") | .Value' | tr -d \'\")"

export SUBNET1="$(echo $PRIVATE_SUBNET_IDS |  cut -d',' -f1)"
sed -i "s|SUBNET1|${SUBNET1}|" cluster.yaml

export SUBNET2="$(echo $PRIVATE_SUBNET_IDS |  cut -d',' -f2)"
sed -i "s|SUBNET2|${SUBNET2}|" cluster.yaml

export SUBNET3="$(echo $PRIVATE_SUBNET_IDS |  cut -d',' -f3)"
sed -i "s|SUBNET3|${SUBNET3}|" cluster.yaml

export ENV="$(cat clustervalues.json  | jq '.Exports[] | select(.Name == "enviroment") | .Value'  | tr -d \'\")"


export DESIRED_CAPACITY="$(cat clustervalues.json  | jq '.Exports[] | select(.Name == "desiredcapacity") | .Value'  | tr -d \'\")"
export INSTANCE_TYPE="$(cat clustervalues.json  | jq '.Exports[] | select(.Name == "instancetype") | .Value'  | tr -d \'\")"
















