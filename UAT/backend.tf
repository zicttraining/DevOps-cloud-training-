terraform {
  backend "s3" {
    bucket       = "bme-uat-app-bucket3"
    key          = "uat/terraform.tfstate"
    region       = "us-west-2"
    use_lockfile = true
    encrypt      = true
  }
}

