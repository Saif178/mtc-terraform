resource "github_repository" "mtc-repo" {
  name        = "mtc-repo"
  description = "Code for MTC"
  visibility  = "private"
  auto_init   = true
}

resource "github_repository_file" "readme" {
  repository          = github_repository.mtc-repo.name
  branch              = "main"
  file                = "README.md"
  content             = "# This repo is for infra devlopers."
  overwrite_on_create = true
}

resource "github_repository_file" "index" {
  repository          = github_repository.mtc-repo.name
  branch              = "main"
  file                = "index.html"
  content             = "<doc><body><h1>hello Terraform</h1></body></doc>"
  overwrite_on_create = true
}

resource "random_id" "random" {
  byte_length = 2
}