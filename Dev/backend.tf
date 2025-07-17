terraform {
  backend "s3" {
    bucket         = "bs101-dev-app-buckettt"
    key            = "dev/terraform.tfstate"         # Use a unique path per environment
    region         = "us-west-2"
    dynamodb_table = "bs101-dev-app-dbb"
    encrypt        = true
  }
}
