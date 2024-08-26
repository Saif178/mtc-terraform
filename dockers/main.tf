resource "null_resource" "dockervol" {
  provisioner "local-exec" {
    command = "script.bat"
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

module "container" {
  source = "C:\\Users\\Saif\\Downloads\\mtc-terraform\\dockers\\container"
  depends_on = [null_resource.dockervol]
  count = local.container_count
  name_in  = join("-", ["nodered", terraform.workspace, random_string.random[count.index].result])
  image_in = module.image.image_out
  int_port_in = var.int_port
  ext_port_in = var.ext_port[terraform.workspace][count.index]
  container_path_in = "/data"
  host_path_in      = "C:\\Users\\Saif\\Downloads\\mtc-terraform\\dockers\\noderedvol"
} 