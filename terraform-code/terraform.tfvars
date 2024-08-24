repo_max = 2
#varsource  = "terraform.tfvars"
env = "prod"
repos = {
  infra = {
    lang     = "terraform",
    filename = "main.tf",
    pages    = true
  },
  backend = {
    lang     = "python",
    filename = "main.py",
    pages    = false
  }
}