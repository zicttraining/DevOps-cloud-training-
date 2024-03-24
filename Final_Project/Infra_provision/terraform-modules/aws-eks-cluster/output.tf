output "eks-cluster-attributes" {
  value = aws_eks_cluster.my-eks
}

output "kubeconfig" {
  value = local.kubeconfig
}