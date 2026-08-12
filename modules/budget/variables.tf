variable "name_prefix" { type = string }
variable "monthly_limit" {
  type    = number
  default = 500
}
variable "threshold_percentage" {
  type    = number
  default = 100
}
variable "notification_email" { type = string }
variable "tags" {
  type    = map(string)
  default = {}
}
