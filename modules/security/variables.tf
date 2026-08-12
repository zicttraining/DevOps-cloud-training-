variable "name_prefix" { type = string }
variable "vpc_id" { type = string }
variable "web_ingress_cidrs" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}
variable "tags" {
  type    = map(string)
  default = {}
}
