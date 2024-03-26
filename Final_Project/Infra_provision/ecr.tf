module "aws-ecr" {
  source = "./terraform-modules/aws-ecr"

  count = length(var.ecr_repositories)
  ecr_repositories = element(var.ecr_repositories, count.index)
}
