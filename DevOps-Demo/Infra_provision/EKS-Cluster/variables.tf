
variable "environment" {}

variable "vpc_cidr_block" {
  type = string
}

variable "max_subnet_count" {
  type = number
}

variable "to_port" {
  type = number
}

variable "from_port" {
  type = number
}

###### AWS EKS Cluster parameters
variable "eks_cluster_policy_names" {
  type = list
}
variable "eks_master_plane_version" {}

###### AWS EKS Cluster node group parameters
variable "instance_types" {}

variable "disk_size" {}
variable "desired_size" {}
variable "max_size" {}
variable "min_size" {}

variable "k8s_version" {
  description = "Kubernetes version"
  default = "1.28.2"
}

variable "eks_nodegroup_policy_names" {
  type = list
}

###### AWS ECR parameters
variable "ecr_repositories" {
  type = list
}
