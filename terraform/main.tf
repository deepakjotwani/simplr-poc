
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
}
module "nodegroup" {
  source  = "./modules/nodegroup"
  cluster_name    = var.cluster_name
   dependencies              = [
    module.cluster.depended_on
  ]

}
provider "kubernetes" {
  host                   = element(concat(data.aws_eks_cluster.cluster[*].endpoint, list("")), 0)
  cluster_ca_certificate = base64decode(element(concat(data.aws_eks_cluster.cluster[*].certificate_authority.0.data, list("")), 0))
  token                  = element(concat(data.aws_eks_cluster_auth.cluster[*].token, list("")), 0)
  load_config_file       = false
}

module "python" {
  source  = "./modules/python"
   dependencies              = [
    module.nodegroup.depended_on
  ]

}
