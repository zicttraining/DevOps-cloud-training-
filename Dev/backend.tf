terraform {
  backend "s3" {
   bucket          = "mc-terraform-state-amber"
    key            = "dev/terraform.tfstate"         # Use a unique path per environment
    region         = "us-east-1"
    #dynamodb_table = "bs101-dev-app-dbb"
    encrypt        = true
  }
}
