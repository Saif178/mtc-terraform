resource "docker_volume" "container_volume" {
  count = var.volume_count
  name  = "${var.volume_name}-${count.index}"
  lifecycle {
    prevent_destroy = false
  }
  #  provisioner "local-exec" {
  #    when = destroy
  #    command = "mkdir C:\\Users\\Saif\\Downloads\\mtc-terraform\\dockers\\backup\\"
  #    on_failure = continue
  #  }
  #  provisioner "local-exec" {
  #    when = destroy
  #    command = "cmd /C tar -czvf \"C:\\Users\\Saif\\Downloads\\mtc-terraform\\dockers\\backup\\${self.name}.tar.gz\" \"${self.mountpoint}\\\""
  #    on_failure = fail
  #  }
}