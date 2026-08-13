variable "name_prefix" { type = string }
variable "vpc_cidr" { type = string }
variable "public_subnets" {
  type = map(object({ cidr = string, az = string }))
}
variable "private_subnets" {
  type = map(object({ cidr = string, az = string }))
}
variable "enable_nat_gateway" {
  type    = bool
  default = true
}
variable "tags" {
  type    = map(string)
  default = {}
}
