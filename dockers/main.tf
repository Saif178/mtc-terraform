terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.2"
    }
  }
}

provider "docker" {}

variable "ext_port" {
  type = number
  default = 1880
  validation {
    condition = var.ext_port <= 65535 && var.ext_port > 0
    error_message = "External port must be between 0 and 65535."
  }
}

variable "int_port" {
  type = number
  default = 1880
  validation {
    condition = var.int_port == 1880
    error_message = "Internal port must be 1880."
  }
}

variable "container_count" {
  type = number
  default = 1
}

resource "random_string" "random" {
  count   = var.container_count
  length  = 4
  special = false
  upper   = false
}

resource "docker_image" "nodered_image" {
  name = "nodered/node-red:latest-22"
}

resource "docker_container" "nodered_container" {
  count = var.container_count
  name  = join("-", ["nodered", random_string.random[count.index].result])
  image = docker_image.nodered_image.image_id
  ports {
    internal = var.int_port
    external = var.ext_port
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