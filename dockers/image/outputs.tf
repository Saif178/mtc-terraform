#---/dockers/image/outputs.tf---

output "image_out" {
  value = docker_image.container_image.image_id
}