variable "ext_port" {
  type = list
  sensitive = true
  validation {
    condition = max(var.ext_port...) <= 65535 && min(var.ext_port...) > 0
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

locals {
  container_count = length(var.ext_port)
}