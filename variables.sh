#!/bin/sh 
export CLUSTER_ROLE_ARN="arn:aws:iam::838660873199:role/eks-cluster-iamrole" | sed -i "s|CLUSTER_ROLE_ARN|${CLUSTER_ROLE_AR}|" cluster.yaml
export NODEGROUP_ROLE_ARN="arn:aws:iam::838660873199:role/eks-node-group-iamrole" | sed -i "s|NODEGROUP_ROLE_ARN|${NODEGROUP_ROLE_ARN}|" cluster.yaml
export INSTANCE_PROFILE_ARN="arn:aws:iam::838660873199:instance-profile/eks-node-group-instance-profile" | sed -i "s|INSTANCE_PROFILE_ARN|${INSTANCE_PROFILE_ARN}|" cluster.yaml
