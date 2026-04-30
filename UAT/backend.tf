terraform {
  backend "s3" {
    bucket         = "bme-uat-app-buckettt"
    key            = "uat/terraform.tfstate"         # Use a unique path per environment
    region         = "us-east-1"
    #dynamodb_table = "bme-uat-app-dbb"
    encrypt        = true
  }
}
