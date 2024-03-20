provider "aws" {
  region = var.region
}

resource "aws_ecr_repository" "my_repository" {
  name = var.ECR_Repository
}