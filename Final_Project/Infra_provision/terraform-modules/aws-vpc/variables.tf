variable "vpc_cidr_block" {
  type = string
}
variable "aws_availability_zones" {}

variable "max_subnet_count" {
    type = number
    default = 1
}

variable "environment" {
    type = string
    default = "devops"
}