# S3 Bucket for application storage with private access
resource "aws_s3_bucket" "bme-uat-app_bucket" {
  bucket = "bme-uat-app-bucket"
  tags = {
    Name = "bme-uat-app-bucket"
  }
}

# S3 Bucket ACL for private access
resource "aws_s3_bucket_acl" "bme-uat-app_bucket_acl" {
  bucket = aws_s3_bucket.bme-uat-app_bucket.id
  acl    = "private"
}

# Ownership controls for S3 bucket
resource "aws_s3_bucket_ownership_controls" "bme-uat-app" {
  bucket = aws_s3_bucket.bme-uat-app_bucket.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}



# EBS Volume for additional storage attached to the web server
resource "aws_ebs_volume" "bme-uat-app_web_ebs" {
  availability_zone = "us-west-2a" # Corrected spelling
  size              = 10              # Size in GB
  tags = {
    Name = "bme-uat-app-web-ebs"
  }
}

