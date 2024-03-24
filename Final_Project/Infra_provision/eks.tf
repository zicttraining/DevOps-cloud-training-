module "eks-cluster" {
  source = "./terraform-modules/aws-eks-cluster"

  subnet_ids                = module.aws-vpc.private_subnet_id
  security_group_ids        = flatten(module.eks-securitygroup.security-group-attributes.*.id)
  environment               = var.environment
  eks_cluster_policy_names  = var.eks_cluster_policy_names
  eks_master_plane_version  = var.eks_master_plane_version
}

module "eks-nodegroup" {
  source = "./terraform-modules/aws-eks-nodegroup"

  eks_cluster_name              = module.eks-cluster.eks-cluster-attributes.id
  subnet_ids                    = module.aws-vpc.private_subnet_id
  instance_types                = [var.instance_types]
  k8s_version                   = var.k8s_version
  disk_size                     = var.disk_size
  desired_size                  = var.desired_size
  max_size                      = var.max_size
  min_size                      = var.min_size
  eks_nodegroup_policy_names    = var.eks_nodegroup_policy_names
  environment                   = var.environment
}
