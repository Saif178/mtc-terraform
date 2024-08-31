#---terraform-aws/variables.tf---

variable "aws_region" {
  default = "us-east-1"
}
variable "access_ip" {
  type = string
}
#---database variables---
variable "dbname" {
  type = string
}

variable "dbuser" {
  type      = string
  sensitive = true
}

variable "dbpassword" {
  type      = string
  sensitive = true
}

variable "public_key_path" {
  type      = string
  sensitive = true
}

variable "path_to_key" {
  type      = string
  sensitive = true
}