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
    when    = destroy
    command = "rmdir /s /q ${self.name}"
  }
}

resource "terraform_data" "repo-clone" {
  depends_on = [github_repository_file.readme, github_repository_file.main]
  for_each   = var.repos
  provisioner "local-exec" {
    command = "gh repo clone ${github_repository.mtc-repo[each.key].name}"
  }
}

resource "github_repository_file" "readme" {
  for_each   = var.repos
  repository = github_repository.mtc-repo[each.key].name
  branch     = "main"
  file       = "README.md"
  content = templatefile("C:\\Users\\Saif\\Downloads\\mtc-terraform\\terraform-code\\template\\readme.tfpl", {
    env         = var.env,
    lang        = each.value.lang,
    repo        = each.key,
    author_name = data.github_user.current.name
  })
  overwrite_on_create = true
  #lifecycle {
  #  ignore_changes = [
  #    content,
  #  ]
  #}
}

resource "github_repository_file" "main" {
  for_each            = var.repos
  repository          = github_repository.mtc-repo[each.key].name
  branch              = "main"
  file                = each.value.filename
  content             = "# Hello ${each.value.lang}"
  overwrite_on_create = true
  lifecycle {
    ignore_changes = [
      content,
    ]
  }
}

#moved {
#  from = github_repository_file.index
#  to   = github_repository_file.main
#}

#resource "random_id" "random" {
#  byte_length = 2
#  count       = var.repo_count
#}