# SSL Dev Environment - Terraform Module
# Author: James Macford Macauley
# Date: 2026

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "ssl_dev_server" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"

  tags = {
    Name        = "SSL-Dev-Server"
    Environment = "Development"
    Project     = "ZICT-DevOps-Training"
  }
}