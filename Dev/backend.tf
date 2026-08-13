terraform {
  backend "s3" {
    bucket         = "bme-dev-app-bucket2"
    key            = "dev/terraform.tfstate"         # Use a unique path per environment
    region         = "us-west-2"
    dynamodb_table = "bme-dev-app-dbb"
    encrypt        = true
  }
}
