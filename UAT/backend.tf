terraform {
  backend "s3" {
    bucket         = "bme-uat-app-bucket3"
    key            = "uat/terraform.tfstate"         # Use a unique path per environment
    region         = "us-west-2"
    dynamodb_table = "bme-uat-app-dbb"
    encrypt        = true
  }
}

