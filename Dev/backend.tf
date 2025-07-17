terraform {
  backend "s3" {
    bucket          = "bs101-dev-app-buckettt"
    key             = "dev/terraform.tfstate"
    region          = "us-west-2"
    encrypt         = true
    use_lock_table  = true
  }
}
