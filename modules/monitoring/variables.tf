variable "name_prefix" { type = string }
variable "notification_email" { type = string }
variable "web_instance_ids" { type = map(string) }
variable "database_instance_id" { type = string }
variable "cpu_threshold" {
  type    = number
  default = 85
}
variable "log_retention_days" {
  type    = number
  default = 7
}
variable "tags" {
  type    = map(string)
  default = {}
}
