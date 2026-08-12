variable "name_prefix" { type = string }
variable "tier" { type = string }
variable "ami_id" { type = string }
variable "instance_type" {
  type    = string
  default = "t3.micro"
}
variable "subnet_ids" { type = list(string) }
variable "security_group_ids" { type = list(string) }
variable "tags" {
  type    = map(string)
  default = {}
}
