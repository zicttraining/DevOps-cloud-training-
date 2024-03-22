locals {
    kubeconfig = templatefile("${path.module}/templates/kubeconfig.tpl", {
    endpoint                                = aws_eks_cluster.my-eks.endpoint
    cluster_auth_base64                     = aws_eks_cluster.my-eks.certificate_authority[0].data
    cluster_name                            = aws_eks_cluster.my-eks.id
})
}