variable "repo_count" {
  type        = number
  description = "number of repositories"
  default     = 1
  validation {
    condition     = var.repo_count < 5
    error_message = "Do not deploy more than 5 repos"
  }
}

#variable "varsource" {
#  type        = string
#  description = "source used to define variables"
#  #default     = "variables.tf"
#}

variable "env" {
  type        = string
  description = "deployment environment"
  validation {
    #condition     = var.env == "dev" || var.env == "prod"
    condition     = contains(["dev", "prod"], var.env)
    error_message = "environment must be 'dev' or 'prod'"
  }
}

#variable "visibility" {
#  type        = string
#  description = "visibility of the repo"
#  default     = var.env == "dev" ? "private" : "public"
#}