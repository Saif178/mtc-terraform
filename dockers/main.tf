terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.2"
    }
  }
}

provider "docker" {}

resource "null_resource" "dockervol" {
  provisioner "local-exec" {
    command = <<EOT
      mkdir noderedvol\ && icacls noderedvol\ /grant Saif:F /T
    EOT
  }
  provisioner "local-exec" {
    when    = destroy
    command = "rmdir /s /q noderedvol"
  }
}

resource "random_string" "random" {
  count   = local.container_count
  length  = 4
  special = false
  upper   = false
}

resource "docker_image" "nodered_image" {
  name = "nodered/node-red:latest-22"
}

resource "docker_container" "nodered_container" {
  count = local.container_count
  name  = join("-", ["nodered", random_string.random[count.index].result])
  image = docker_image.nodered_image.image_id
  ports {
    internal = var.int_port
    external = var.ext_port[count.index]
  }
  volumes {
    container_path = "/data"
    host_path = "C:\\Users\\Saif\\Downloads\\mtc-terraform\\dockers\\noderedvol"
  }
} 