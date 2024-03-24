#modules/ec2-layer/variables.tf
variable "env" {}
variable "region" {}
variable "vpc_id_jenkins" {}
variable "subnet_id_jenkins" {}

# Variable for ec2
variable instance_type {}
variable volume_size {}
