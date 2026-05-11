terraform {
  backend "s3" {
    bucket         = "MC-uat-app-buckettt"
    key            = "uat/terraform.tfstate"         # Use a unique path per environment
    region         = "us-east-1"
    #dynamodb_table = "MC-uat-app-dbb"
    encrypt        = true
  }
}
