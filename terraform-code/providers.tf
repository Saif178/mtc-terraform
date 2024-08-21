terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
  }
}

provider "github" {
  owner = "Saif178"
  token = var.github_token
}

variable "github_token" {
  description = "The GitHub token for authenticating API requests."
  type        = string
}
