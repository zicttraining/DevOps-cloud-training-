variable "environment" {
    type = string
    default = "devops"
}

variable "eks_master_plane_version" {}
variable "subnet_ids" {}
variable "security_group_ids" {}
variable "eks_cluster_policy_names" {}