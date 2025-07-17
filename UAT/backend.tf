terraform {
  backend "s3" {
    bucket          = "bs101-uat-app-buckettt"
    key             = "uat/terraform.tfstate"
    region          = "us-west-2"
    encrypt         = true
    use_lock_table  = true
  }
}
