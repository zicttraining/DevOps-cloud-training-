locals {
  name_prefix = lower("${var.project_name}-${var.environment}")
  common_tags = merge(var.tags, {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  })
}

data "aws_ssm_parameter" "amazon_linux_2023_ami" {
  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
}

module "vpc" {
  source             = "../vpc"
  name_prefix        = local.name_prefix
  vpc_cidr           = var.vpc_cidr
  public_subnets     = var.public_subnets
  private_subnets    = var.private_subnets
  enable_nat_gateway = var.enable_nat_gateway
  tags               = local.common_tags
}

module "security" {
  source      = "../security"
  name_prefix = local.name_prefix
  vpc_id      = module.vpc.vpc_id
  tags        = local.common_tags
}

module "web" {
  source             = "../compute"
  name_prefix        = local.name_prefix
  tier               = "web"
  ami_id             = coalesce(var.ami_id, data.aws_ssm_parameter.amazon_linux_2023_ami.value)
  instance_type      = var.instance_type
  subnet_ids         = module.vpc.public_subnet_ids
  security_group_ids = [module.security.web_security_group_id]
  tags               = local.common_tags
}

module "app" {
  source             = "../compute"
  name_prefix        = local.name_prefix
  tier               = "app"
  ami_id             = coalesce(var.ami_id, data.aws_ssm_parameter.amazon_linux_2023_ami.value)
  instance_type      = var.instance_type
  subnet_ids         = module.vpc.private_subnet_ids
  security_group_ids = [module.security.app_security_group_id]
  tags               = local.common_tags
}

module "database" {
  source                  = "../database"
  name_prefix             = local.name_prefix
  subnet_ids              = module.vpc.private_subnet_ids
  security_group_id       = module.security.database_security_group_id
  database_name           = var.database_name
  database_username       = var.database_username
  database_password       = var.database_password
  deletion_protection     = var.database_deletion_protection
  skip_final_snapshot     = var.database_skip_final_snapshot
  backup_retention_period = var.database_backup_retention_period
  tags                    = local.common_tags
}

module "networking" {
  source                = "../networking"
  name_prefix           = local.name_prefix
  vpc_id                = module.vpc.vpc_id
  public_subnet_ids     = module.vpc.public_subnet_ids
  alb_security_group_id = module.security.alb_security_group_id
  web_instance_ids      = module.web.instance_ids
  domain_name           = var.domain_name
  tags                  = local.common_tags
}

module "storage" {
  source      = "../storage"
  name_prefix = local.name_prefix
  tags        = local.common_tags
}

module "monitoring" {
  source               = "../monitoring"
  name_prefix          = local.name_prefix
  notification_email   = var.notification_email
  web_instance_ids     = module.web.instance_ids
  database_instance_id = module.database.instance_id
  tags                 = local.common_tags
}

module "budget" {
  source             = "../budget"
  name_prefix        = local.name_prefix
  monthly_limit      = var.monthly_budget
  notification_email = var.notification_email
  tags               = local.common_tags
}
