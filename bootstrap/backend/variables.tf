variable "aws_region" {
  type    = string
  default = "us-west-2"
}
variable "state_bucket_name" { type = string }
variable "tags" {
  type = map(string)
  default = {
    ManagedBy = "Terraform"
    Program   = "ZiCloudTech"
  }
}
