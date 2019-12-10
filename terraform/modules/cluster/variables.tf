
variable "cluster_name" {
  description = "Name of the EKS cluster. Also used as a prefix in names of related resources."
  type        = string
  default = "simplr-demo-cluster"
}

variable "cluster_version" {
  description = "Kubernetes version to use for the EKS cluster."
  type        = string
  default     = "1.14"
}

variable "subnets" {
  description = "A list of subnets to place the EKS cluster and workers within."
  type        = list(string)
  default = ["subnet-06e2e100ebfa9a574", "subnet-0bbeda2c05f614427", "subnet-0d291755f72dd5b83"]
}

variable "security_group_ids" {
  description = "A list of Security Groups to place the EKS cluster and workers within."
  type        = list(string)
  default = ["sg-0144f9d6e9e718b50"]
}

variable "vpc_id" {
  description = "VPC where the cluster and workers will be deployed."
  type        = string
  default = "vpc-08c54b71caa4efdc9"
}
variable "dependencies" {
  type    = list
  default = []
}