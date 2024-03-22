variable "eks_cluster_name" {}

variable "subnet_ids" {}
variable "instance_types" {}
variable "k8s_version" {
  description = "Define the kubernetes version"
  default = "1.28.2"
}

variable "disk_size" {
  description = "disk size of EKS worker node VM"
  default = 20
}

variable "desired_size" {}
variable "max_size" {}
variable "min_size" {}

variable "eks_nodegroup_policy_names" {
  description = "AWS EKS worker node policy"
}

variable "environment" {
  type = string
  default = "devops"
}