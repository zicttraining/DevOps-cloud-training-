variable "region_1" {
  description = "Region for the first VPC"
  default     = "us-west-1"
}

variable "region_2" {
  description = "Region for the second VPC"
  default     = "us-east-1"
}

variable "ami" {
  description = "AMI ID for the web server instances"
  type        = string
  default     = "ami-036c2987dfef867fb"
}

variable "ami2" {
  description = "AMI ID for the web server instances"
  type        = string
  default     = "ami-0da424eb883458071"
}


variable "instance_type" {
  description = "Instance type for the web server"
  default     = "t2.micro"
}
