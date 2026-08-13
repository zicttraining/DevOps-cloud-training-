aws_region   = "us-west-2"
project_name = "BME-WEb-App"
environment  = "uat"
vpc_cidr     = "10.20.0.0/16"
public_subnets = {
  a = { cidr = "10.20.1.0/24", az = "us-west-2a" }
  b = { cidr = "10.20.2.0/24", az = "us-west-2b" }
}
private_subnets = {
  a = { cidr = "10.20.11.0/24", az = "us-west-2a" }
  b = { cidr = "10.20.12.0/24", az = "us-west-2b" }
}
enable_nat_gateway               = true
ami_id                           = null
instance_type                    = "t3.micro"
database_name                    = "BMEuatdb"
database_username                = "admin"
database_deletion_protection     = false
database_skip_final_snapshot     = true
database_backup_retention_period = 3
domain_name                      = null
notification_email               = "ogahsam@gmail.com"
monthly_budget                   = 500
tags                             = { OwnerTeam = "BME-Cloudengineers" }
