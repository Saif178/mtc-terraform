data "terraform_remote_state" "kubeconfig" {
    backend = "remote"

    config = {
        organization = "TDC-178"
        workspaces = {
            name = "mtc-dev"
        }
    }
}