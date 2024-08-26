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

module image {
  source = "C:\\Users\\Saif\\Downloads\\mtc-terraform\\dockers\\image"
  image_in = var.image[terraform.workspace]
}

resource "docker_container" "nodered_container" {
  count = local.container_count
  name  = join("-", ["nodered", terraform.workspace, random_string.random[count.index].result])
  image = module.image.image_out
  ports {
    internal = var.int_port
    external = var.ext_port[terraform.workspace][count.index]
  }
  volumes {
    container_path = "/data"
    host_path      = "${path.cwd}\\noderedvol"
  }
} 