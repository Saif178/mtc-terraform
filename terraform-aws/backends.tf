terraform {
  cloud {

    organization = "TDC-178"

    workspaces {
      name = "mtc-dev"
    }
  }
}