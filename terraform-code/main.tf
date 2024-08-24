module "repos" {
    source = "C:\\Users\\Saif\\Downloads\\mtc-terraform\\terraform-code\\modules\\dev-repos"
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
}