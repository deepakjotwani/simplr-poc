resource "aws_eks_node_group" "eks_node_group" {
  cluster_name    = var.cluster_name
  node_role_arn   = aws_iam_role.eks-node-group-iamrole.arn
  node_group_name = var.nodegroup_name
  subnet_ids      = var.subnets
  instance_types  = ["t2.micro"]

  scaling_config {
    desired_size = 1
    max_size     = 1
    min_size     = 1
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.simplr-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.simplr-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.simplr-AmazonEC2ContainerRegistryReadOnly,
  ]
}

resource "aws_iam_role" "eks-node-group-iamrole" {
  name = "eks-node-group-iamrole"

  assume_role_policy = jsonencode({
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "simplr-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks-node-group-iamrole.name
}

resource "aws_iam_role_policy_attachment" "simplr-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks-node-group-iamrole.name
}

resource "aws_iam_role_policy_attachment" "simplr-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks-node-group-iamrole.name
}
resource "null_resource" "dependency_setter" {
  depends_on = [ aws_eks_node_group.eks_node_group ]
}
