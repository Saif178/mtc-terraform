resource "github_repository" "mtc-repo" {
  for_each    = var.repos
  name        = "mtc-repo-${each.key}"
  description = "${each.value} code for MTC"
  visibility  = var.env == "dev" ? "private" : "public"
  auto_init   = true
  provisioner "local-exec" {
    command = "gh repo view ${self.name} --web"
  }
  provisioner "local-exec" {
    command = "gh repo clone ${self.name}"
  }
}


resource "github_repository_file" "readme" {
  for_each            = var.repos
  repository          = github_repository.mtc-repo[each.key].name
  branch              = "main"
  file                = "README.md"
  content             = "# This ${var.env} repo is for infra devlopers."
  overwrite_on_create = true
}

resource "github_repository_file" "index" {
  for_each            = var.repos
  repository          = github_repository.mtc-repo[each.key].name
  branch              = "main"
  file                = "index.html"
  content             = "<doc><body><h1>hello Terraform</h1></body></doc>"
  overwrite_on_create = true
}

#resource "random_id" "random" {
#  byte_length = 2
#  count       = var.repo_count
#}

output "repo-names" {
  value       = [for repo in github_repository.mtc-repo : repo.name]
  description = "Repository names"
  sensitive   = true
}

output "clone-urls" {
  value       = { for repo in github_repository.mtc-repo : repo.name => repo.http_clone_url }
  description = "Repository URLs"
  sensitive   = false
}

#output "varsource" {
#  value       = var.varsource
#  description = "source being used to source variable definition"
#}