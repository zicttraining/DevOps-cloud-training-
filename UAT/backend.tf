terraform {
  backend "s3" {
    bucket         = "bs101-uat-app-buckettt"
    key            = "uat/terraform.tfstate"         # Use a unique path per environment
    region         = "us-east-1"
    #dynamodb_table = "bs101-uat-app-dbb"
    encrypt        = true
  }
}
