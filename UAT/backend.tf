terraform {
  backend "s3" {
    bucket         = "bs101-uat-app-buckettt"
    key            = "uat/terraform.tfstate"         # Use a unique path per environment
    region         = "us-west-2"
    dynamodb_table = "bs101-uat-app-dbb"
    encrypt        = true
  }
}
