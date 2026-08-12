variable "name_prefix" { type = string }
variable "vpc_id" { type = string }
variable "public_subnet_ids" { type = list(string) }
variable "alb_security_group_id" { type = string }
variable "web_instance_ids" { type = map(string) }
variable "domain_name" {
  type    = string
  default = null
}
variable "tags" {
  type    = map(string)
  default = {}
}
