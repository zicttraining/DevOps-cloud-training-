resource "aws_eks_node_group" "my-eks-nodegroup" {
  cluster_name    = var.eks_cluster_name
  node_group_name = "${var.environment}-node-group"
  node_role_arn   = aws_iam_role.eks-nodegroup-role.arn
  subnet_ids      = var.subnet_ids
  instance_types  = var.instance_types
  version = var.k8s_version
  disk_size = var.disk_size

  scaling_config {
    desired_size = var.desired_size
    max_size     = var.max_size
    min_size     = var.min_size
  }
 

  depends_on = [aws_iam_role_policy_attachment.eks-nodegroup-iam-policy]
}

resource "aws_iam_role" "eks-nodegroup-role" {
  name = "${var.environment}-eks-node-group"

  assume_role_policy = jsonencode({
    "Version" = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "eks-nodegroup-iam-policy" {
  count = length(var.eks_nodegroup_policy_names)
  policy_arn = format("%s/%s", "arn:aws:iam::aws:policy", element(var.eks_nodegroup_policy_names, count.index))
  role       = aws_iam_role.eks-nodegroup-role.name
}

