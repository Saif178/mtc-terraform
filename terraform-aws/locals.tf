#---/terraform-aws/locals.tf

locals {
  vpc_cidr = "10.124.0.0/16"
}

locals {
  security_groups = {
    public = {
      name        = "public_sg"
      description = "security group for public access"
      ingress = {
        open = {
          from        = 0
          to          = 0
          protocol    = -1
          cidr_blocks = [var.access_ip]
        }
        ssh = {
          from        = 22
          to          = 22
          protocol    = "tcp"
          cidr_blocks = [var.access_ip]
        }
        http = {
          from        = 80
          to          = 80
          protocol    = "tcp"
          cidr_blocks = [var.access_ip]
        }
        nginx = {
          from        = 8000
          to          = 8000
          protocol    = "tcp"
          cidr_blocks = ["0.0.0.0/0"]
        }
      }
    }
    rds = {
      name        = "rds_sg"
      description = "security group for rds access"
      ingress = {
        mysql = {
          from        = 3306
          to          = 3306
          protocol    = "tcp"
          cidr_blocks = [local.vpc_cidr]
        }
      }
    }
  }
}