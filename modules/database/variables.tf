variable "name_prefix" { type = string }
variable "subnet_ids" { type = list(string) }
variable "security_group_id" { type = string }
variable "allocated_storage" {
  type    = number
  default = 20
}
variable "engine_version" {
  type    = string
  default = "8.0"
}
variable "instance_class" {
  type    = string
  default = "db.t3.micro"
}
variable "database_name" { type = string }
variable "database_username" { type = string }
variable "database_password" {
  type      = string
  sensitive = true
}
variable "skip_final_snapshot" {
  type    = bool
  default = true
}
variable "deletion_protection" {
  type    = bool
  default = false
}
variable "backup_retention_period" {
  type    = number
  default = 1
}
variable "tags" {
  type    = map(string)
  default = {}
}
