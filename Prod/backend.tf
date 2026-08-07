terraform {
  backend "s3" {
    bucket         = "bme-prod-app-bucket4"
    key            = "prod/terraform.tfstate"         # Use a unique path per environment
    region         = "us-west-2"
    dynamodb_table = "bme-prod-app-dbb"
    encrypt        = true
  }
}

