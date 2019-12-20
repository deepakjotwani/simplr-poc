#!/bin/sh 
export CLUSTER_ROLE_ARN="$(aws cloudformation --region us-east-2 list-exports  | jq '.Exports[] | select(.Name == "rolesinfra-ClusterRoleARN") | .Value' | tr -d \'\")" | sed -i "s|CLUSTER_ROLE_ARN|${CLUSTER_ROLE_ARN}|" cluster.yaml
export NODEGROUP_ROLE_ARN="$(aws cloudformation --region us-east-2 list-exports  | jq '.Exports[] | select(.Name == "rolesinfra-NodeGroupRoleARN") | .Value' | tr -d \'\")" | sed -i "s|NODEGROUP_ROLE_ARN|${NODEGROUP_ROLE_ARN}|" cluster.yaml
export INSTANCE_PROFILE_ARN="$(aws cloudformation --region us-east-2 list-exports  | jq '.Exports[] | select(.Name == "rolesinfra-NodeGroupInstanceProfileARN") | .Value' | tr -d \'\")" | sed -i "s|INSTANCE_PROFILE_ARN|${INSTANCE_PROFILE_ARN}|" cluster.yaml
