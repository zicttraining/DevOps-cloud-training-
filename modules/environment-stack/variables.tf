variable "project_name" { type = string }
variable "environment" { type = string }
variable "vpc_cidr" { type = string }
variable "public_subnets" { type = map(object({ cidr = string, az = string })) }
variable "private_subnets" { type = map(object({ cidr = string, az = string })) }
variable "enable_nat_gateway" {
  type    = bool
  default = true
}
variable "ami_id" {
  type    = string
  default = null
}
variable "instance_type" {
  type    = string
  default = "t3.micro"
}
variable "database_name" { type = string }
variable "database_username" { type = string }
variable "database_password" {
  type      = string
  sensitive = true
}
variable "database_deletion_protection" {
  type    = bool
  default = false
}
variable "database_skip_final_snapshot" {
  type    = bool
  default = true
}
variable "database_backup_retention_period" {
  type    = number
  default = 1
}
variable "domain_name" {
  type    = string
  default = null
}
variable "notification_email" { type = string }
variable "monthly_budget" {
  type    = number
  default = 500
}
variable "tags" {
  type    = map(string)
  default = {}
}
