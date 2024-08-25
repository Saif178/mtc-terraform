terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.2"
    }
  }
}

provider "docker" {}

resource "docker_image" "nodered_image" {
  name = "nodered/node-red:latest-22"
}

resource "docker_container" "nodered_container" {
  name  = "nodered"
  image = docker_image.nodered_image.image_id
  ports {
    internal = 1880
    external = 1880
  }
}

output "ip_address" {
    value = join(":", [docker_container.nodered_container.network_data[0].ip_address, docker_container.nodered_container.ports[0].external])
    description = "the ip address and external port of the container"
}

output "container_name" {
    value = docker_container.nodered_container.name
    description = "the name of the container"
}