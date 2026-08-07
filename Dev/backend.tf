terraform {
  backend "s3" {
    bucket       = "bme-dev-app-bucket2"
    key          = "dev/terraform.tfstate"
    region       = "us-west-2"
    use_lockfile = true
    encrypt      = true
  }
}
