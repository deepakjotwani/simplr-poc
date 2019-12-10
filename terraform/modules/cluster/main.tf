resource "aws_eks_cluster" "eks_cluster" {
  name                      = var.cluster_name
  role_arn                  = "${aws_iam_role.eks-cluster-iamrole.arn}"
  version                   = var.cluster_version

  vpc_config {
    subnet_ids              = var.subnets
    security_group_ids     = var.security_group_ids
  }

  depends_on = [
    aws_iam_role_policy_attachment.cluster_AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.cluster_AmazonEKSServicePolicy,
    aws_iam_role.eks-cluster-iamrole,

  ]
}


resource "aws_iam_openid_connect_provider" "simplr-openid_connect_provider" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = []
  url             = "${aws_eks_cluster.eks_cluster.identity.0.oidc.0.issuer}"
}

data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "simplr_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(aws_iam_openid_connect_provider.simplr-openid_connect_provider.url, "https://", "")}:sub"
      values   = ["system:serviceaccount:kube-system:aws-node"]
    }

    principals {
      identifiers = ["${aws_iam_openid_connect_provider.simplr-openid_connect_provider.arn}"]
      type        = "Federated"
    }
  }
}

resource "aws_iam_role" "eks-cluster-iamrole" {
  name = "eks-cluster-iamrole"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "cluster_AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = "${aws_iam_role.eks-cluster-iamrole.name}"
}

resource "aws_iam_role_policy_attachment" "cluster_AmazonEKSServicePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = "${aws_iam_role.eks-cluster-iamrole.name}"
}
