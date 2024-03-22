resource "aws_ecr_repository" "image-repo" {
  name                 = var.ecr_repositories
}