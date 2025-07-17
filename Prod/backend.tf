terraform {
  backend "s3" {
    bucket          = "bs101-prod-app-buckettt"
    key             = "prod/terraform.tfstate"
    region          = "us-west-2"
    encrypt         = true
    use_lock_table  = true
  }
}
