output "repo-names" {
  value       = [for repo in github_repository.mtc-repo : repo.name]
  description = "Repository names"
  sensitive   = true
}

output "clone-urls" {
  value = {
    for repo in github_repository.mtc-repo : repo.name => {  
      ssh_clone_url  = repo.ssh_clone_url,
      http_clone_url = repo.http_clone_url,
      pages_url      = try(repo.pages[0].html_url, "no page")
    }
  }
  description = "Repository URLs"
  sensitive   = false
}

#output "varsource" {
#  value       = var.varsource
#  description = "source being used to source variable definition"
#}