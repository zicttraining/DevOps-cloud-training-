variable "region" {
  default = "us-west-2"
  type    = string
}

variable "project" {
  description = "The project name to use for unique resource naming"
  default     = "nhu.luong"
  type        = string
}

variable "principal_arns" {
  description = "A list of principal arns allowed to assume the IAM role"
  default     = null
  type        = list(string)
}