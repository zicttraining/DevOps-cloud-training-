output "eks_cluster_name" {
  value = module.eks-cluster.eks-cluster-attributes.id
}

output "eks_nodegroup_name" {
  value = module.eks-nodegroup.eks_nodegroup_attributes.id
}

output "vpc_id" {
  value = module.aws-vpc.vpc_attributes.id 
}

output "kubeconfig" {
  value = module.eks-cluster.kubeconfig
}