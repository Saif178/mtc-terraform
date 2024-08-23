resource "github_repository" "mtc-repo" {
  count       = 2
  name        = "mtc-repo-${random_id.random[count.index].dec}"
  description = "Code for MTC"
  visibility  = "private"
  auto_init   = true
}


resource "github_repository_file" "readme" {
  count               = var.repo_count
  repository          = github_repository.mtc-repo[count.index].name
  branch              = "main"
  file                = "README.md"
  content             = "# This repo is for infra devlopers."
  overwrite_on_create = true
}

resource "github_repository_file" "index" {
  count               = var.repo_count
  repository          = github_repository.mtc-repo[count.index].name
  branch              = "main"
  file                = "index.html"
  content             = "<doc><body><h1>hello Terraform</h1></body></doc>"
  overwrite_on_create = true
}

resource "random_id" "random" {
  byte_length = 2
  count       = var.repo_count
}

output "repo-names" {
  value       = github_repository.mtc-repo[*].name
  description = "Repository names"
  sensitive   = true
}

output "clone-urls" {
  value       = { for repo in github_repository.mtc-repo[*] : repo.name => repo.http_clone_url }
  description = "Repository URLs"
  sensitive   = false
}

#output "varsource" {
#  value       = var.varsource
#  description = "source being used to source variable definition"
#}