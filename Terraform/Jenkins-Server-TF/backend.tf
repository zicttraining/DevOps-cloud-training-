terraform {
  backend "s3" {
    bucket = "my-aws-baketname"
    region         = "us-west-2"
    access_key     = "xxx"
    secret_key     = "xxx" 
    key    = "DevOps-devops/Terraform/Jenkins-Server-TF/terraform.tfstate"
    dynamodb_table = "Lock-Files"
    encrypt        = true
  }
}