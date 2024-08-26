variable "image" {
  type = map(any)
  default = {
    dev  = "nodered/node-red:latest"
    prod = "nodered/node-red:latest-minimal"
  }
  description = "image for container"
}

variable "ext_port" {
  type      = map(any)
  sensitive = false
  validation {
    condition     = max(var.ext_port["dev"]...) <= 65535 && min(var.ext_port["dev"]...) >= 1980
    error_message = "External port must be between 1980 and 65535."
  }
  validation {
    condition     = max(var.ext_port["prod"]...) < 1980 && min(var.ext_port["prod"]...) >= 1880
    error_message = "External port must be between 1880 and 1980."
  }
}

variable "int_port" {
  type    = number
  default = 1880
  validation {
    condition     = var.int_port == 1880
    error_message = "Internal port must be 1880."
  }
}

locals {
  container_count = length(var.ext_port[terraform.workspace])
}