aws_region   = "us-west-2"
project_name = "BME-Web-App"
environment  = "dev"
vpc_cidr     = "10.10.0.0/16"
public_subnets = {
  a = { cidr = "10.10.1.0/24", az = "us-west-2a" }
  b = { cidr = "10.10.2.0/24", az = "us-west-2b" }
}
private_subnets = {
  a = { cidr = "10.10.11.0/24", az = "us-west-2a" }
  b = { cidr = "10.10.12.0/24", az = "us-west-2b" }
}
enable_nat_gateway               = true
ami_id                           = null
instance_type                    = "t3.micro"
database_name                    = "BMEdevdb"
database_username                = "admin"
database_deletion_protection     = false
database_skip_final_snapshot     = true
database_backup_retention_period = 1
domain_name                      = null
notification_email               = "ogahsam@gmail.com"
monthly_budget                   = 500
tags                             = { OwnerTeam = "BME-Cloudengineers" }
