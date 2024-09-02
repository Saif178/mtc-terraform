terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "6.2.3"
    }

    tfe = {
      source = "hashicorp/tfe"
    }
  }
}

provider "github" {
  token = var.github_token
  owner = var.github_owner
}

provider "tfe" {
  token = var.tfe_token
}