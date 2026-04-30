terraform {
  backend "s3" {
    bucket         = "ssl-dev-buckek"
    key            = "dev/terraform.tfstate"         # Use a unique path per environment
    region         = "af-south-1"
    #dynamodb_table = "ssl-dev-app-dbb"
    encrypt        = true
  }
}
