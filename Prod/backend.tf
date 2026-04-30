terraform {
  backend "s3" {
    bucket         = "bme-prod-app-buckettt"
    key            = "prod/terraform.tfstate"         # Use a unique path per environment
    region         = "us-east-2"
    #dynamodb_table = "bme-prod-app-dbb"
    encrypt        = true
  }
}

