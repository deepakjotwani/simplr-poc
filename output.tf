
output "cluster-iamrole-arn" {
  value = "${aws_iam_role.eks-cluster-iamrole.arn}"
}

output "nodegroup-iamrole-arn" {
  value = "${aws_iam_role.eks-node-group-iamrole.arn}"
}

output "nodegroup-instance-profile-arn" {
  value = "${aws_iam_instance_profile.nodegroup-instance-profile.arn}"
}