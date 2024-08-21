resource "github_repository" "mtc-repo" {
  name        = "mtc-repo"
  description = "Code for MTC"
  visibility  = "private"
  auto_init   = true
}