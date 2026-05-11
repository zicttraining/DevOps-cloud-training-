terraform {
  backend "s3" {
    bucket         = "mc-uat-app-buckettt"
    key            = "uat/terraform.tfstate"         # Use a unique path per environment
    region         = "us-east-1"
    #dynamodb_table = "mc-uat-app-dbb"
    encrypt        = true
  }
}
