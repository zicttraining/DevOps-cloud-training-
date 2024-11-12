# S3 Bucket for application storage with private access
resource "aws_s3_bucket" "bme-uat-app" {
  bucket = "bme-uat-app" # Bucket name
  acl    = "private"      # Private access control list
}

# EBS Volume for additional storage attached to the web server
resource "aws_ebs_volume" "bme-uat-app_web_ebs" {
  availability_zone = "us-west-2a" # Availability zone for the EBS volume
  size              = 10           # Size in GB
  tags = {
    Name = "bme-uat-app-web-ebs" # Tag for identification
  }
}
