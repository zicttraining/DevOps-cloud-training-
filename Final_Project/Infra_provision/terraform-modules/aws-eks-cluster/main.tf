resource "aws_eks_cluster" "my-eks" {
  name     = "${var.environment}-eks-cluster"
  role_arn = aws_iam_role.eks-role.arn
  version = var.eks_master_plane_version

  vpc_config {
    subnet_ids          = var.subnet_ids
    security_group_ids  = var.security_group_ids
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks-cluster-policy
  ]
}


resource "aws_iam_role" "eks-role" {
  name = "${var.environment}-eks-role"

  assume_role_policy = jsonencode({
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "eks.amazonaws.com"
      }
    }
  ]
})
}

resource "aws_iam_role_policy_attachment" "eks-cluster-policy" {
  count = length(var.eks_cluster_policy_names)
  policy_arn = format("%s/%s", "arn:aws:iam::aws:policy", element(var.eks_cluster_policy_names, count.index))
  role       = aws_iam_role.eks-role.name
}
