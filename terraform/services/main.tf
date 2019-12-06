
data "aws_eks_cluster" "cluster" {
  name = module.cluster.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.cluster.cluster_id
}
provider "aws" {
  region      = "us-east-2"
}

# Create EKS cluster
module "cluster" {
  source = "./modules/cluster"
  cluster_name    = "simplr-demo-cluster"
  cluster_version = "1.14"
  subnets         = ["subnet-06e2e100ebfa9a574", "subnet-0bbeda2c05f614427", "subnet-0d291755f72dd5b83"]
  vpc_id          = "vpc-08c54b71caa4efdc9"
  worker_groups = [
    {
      instance_type = "t2.micro"
      asg_max_size  = 3
    }
  ]
}
provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.cluster.token
  load_config_file       = false
}

module "python" {
  source  = "./modules/python"

}
