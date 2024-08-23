variable "repo_max" {
  type        = number
  description = "number of repositories"
  default     = 2
  validation {
    condition     = var.repo_max <= 10
    error_message = "Do not deploy more than 10 repos"
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

variable "repos" {
    type = set(string)
    description = "repositories"
    validation {
        condition = length(var.repos) <= var.repo_max
        error_message = "Please do not deploy more than the ${var.repo_max} allows"
    }
}