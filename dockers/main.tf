terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.2"
    }
  }
}

provider "docker" {}

resource "random_string" "random" {
  count   = 2
  length  = 4
  special = false
  upper   = false
}

resource "docker_image" "nodered_image" {
  name = "nodered/node-red:latest-22"
}

resource "docker_container" "nodered_container" {
  count = 2
  name  = join("-", ["nodered", random_string.random[count.index].result])
  image = docker_image.nodered_image.image_id
  ports {
    internal = 1880
    #external = 1880
  }
}

output "container_name" {
  value       = docker_container.nodered_container[*].name
  description = "the name of the containers"
}

output "ip_address" {
  value = flatten([
    for i in docker_container.nodered_container[*] : [
        for ip, port in zipmap(i.network_data[*].ip_address, i.ports[*].external) : join(":", [ip, tostring(port)])
    ]
  ])
  description = "the ip address and external port of the containers"
}