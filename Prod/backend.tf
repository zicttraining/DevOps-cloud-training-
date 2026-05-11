terraform {
  backend "s3" {
    bucket         = "mc-prod-state-amber"
    key            = "prod/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
  }
}
