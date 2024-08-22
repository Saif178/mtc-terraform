resource "github_repository" "mtc-repo" {
  count       = 2
  name        = "mtc-repo-${random_id.random[count.index].dec}"
  description = "Code for MTC"
  visibility  = "private"
  auto_init   = true
}


resource "github_repository_file" "readme" {
  count               = 2
  repository          = github_repository.mtc-repo[count.index].name
  branch              = "main"
  file                = "README.md"
  content             = "# This repo is for infra devlopers."
  overwrite_on_create = true
}

resource "github_repository_file" "index" {
  count               = 2
  repository          = github_repository.mtc-repo[count.index].name
  branch              = "main"
  file                = "index.html"
  content             = "<doc><body><h1>hello Terraform</h1></body></doc>"
  overwrite_on_create = true
}

resource "random_id" "random" {
  byte_length = 2
  count       = 2
}

output "repo-names" {
  value = github_repository.mtc-repo[*].name
  description = "Repository names"
  sensitive   = true
}