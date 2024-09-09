#---/dockers/container/volume/main.tf---

resource "docker_volume" "container_volume" {
  count = var.volume_count
  name  = "${var.volume_name}-${count.index}"
  lifecycle {
    prevent_destroy = false
  }
  provisioner "local-exec" {
    when       = destroy
    command    = "mkdir C:\\Users\\Saif\\Downloads\\Udemy_labs\\mtc-terraform\\dockers\\backup\\"
    on_failure = continue
  }
  provisioner "local-exec" {
    when       = destroy
    command    = "tar -czvf C:\\Users\\Saif\\Downloads\\Udemy_labs\\mtc-terraform\\dockers\\backup\\${self.name}.tar.gz ${self.mountpoint}\\"
    on_failure = fail
  }
}