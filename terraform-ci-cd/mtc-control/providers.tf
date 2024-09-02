terraform {
    required_providers {
        github = {
            source = "integerations/github"
            version = "4.13.0"
        }

        tfe = {
            source = "hashicorp/tfe"
        }
    }
}

provider "github" {
    token = var.github_token
    owner = vat.github_owner
}

provider "tfe" {
    token = 
}