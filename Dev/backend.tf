terraform {
  backend "s3" {
    bucket         = "bme-dev-app-buckettt"
    key            = "dev/terraform.tfstate"         # Use a unique path per environment
    region         = "us-east-1"
    #dynamodb_table = "bme-dev-app-dbb"
    encrypt        = true
  }
}
