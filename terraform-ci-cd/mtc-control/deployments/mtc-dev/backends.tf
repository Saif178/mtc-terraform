terraform {
  backend "remote" {
      organization = "TDC-178"
  workspaces {
      name = "mtc-dev-repo"
    }
  }
}