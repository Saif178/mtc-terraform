resource "github_repository" "mtc-repo" {
  for_each    = var.repos
  name        = "mtc-repo-${each.key}"
  description = "${each.value.lang} Code for MTC"
  visibility  = var.env == "dev" ? "private" : "public"
  auto_init   = true
  provisioner "local-exec" {
    command = "gh repo view ${self.name} --web"
  }
  provisioner "local-exec" {
    when      = destroy
    command   = "rmdir /s /q ${self.name}"
  }
}

resource "terraform_data" "repo-clone" {
  depends_on = [github_repository_file.readme, github_repository_file.index]
  for_each   = var.repos
  provisioner "local-exec" {
    command = "gh repo clone ${github_repository.mtc-repo[each.key].name}"
  }
}

resource "github_repository_file" "readme" {
  for_each            = var.repos
  repository          = github_repository.mtc-repo[each.key].name
  branch              = "main"
  file                = "README.md"
  content             = "# This is a ${var.env} ${each.value.lang} repo for ${each.key} devlopers."
  overwrite_on_create = true
}

resource "github_repository_file" "index" {
  for_each            = var.repos
  repository          = github_repository.mtc-repo[each.key].name
  branch              = "main"
  file                = each.value.filename
  content             = "# Hello ${each.value.lang}"
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
  value       = { for repo in github_repository.mtc-repo : repo.name => [repo.ssh_clone_url, repo.http_clone_url] }
  description = "Repository URLs"
  sensitive   = false
}

#output "varsource" {
#  value       = var.varsource
#  description = "source being used to source variable definition"
#}