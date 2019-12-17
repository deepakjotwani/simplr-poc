variable "subnets" {
  description = "A list of subnets to place the EKS cluster and workers within."
  type        = list(string)
  default = ["subnet-06e2e100ebfa9a574", "subnet-0bbeda2c05f614427", "subnet-0d291755f72dd5b83"]
}
variable "vpcid" {
  description = "VPC where the cluster and workers will be deployed."
  type        = string
  default = "vpc-08c54b71caa4efdc9"
}