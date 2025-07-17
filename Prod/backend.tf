terraform {
  backend "s3" {
    bucket         = "bs101-prod-app-buckettt"
    key            = "prod/terraform.tfstate"         # Use a unique path per environment
    region         = "us-west-2"
    #dynamodb_table = "bs101-prod-app-dbb"
    encrypt        = true
  }
}

