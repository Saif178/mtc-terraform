#---/dockers/main.tf---

module "image" {
  source   = "C:\\Users\\Saif\\Downloads\\Udemy_labs\\mtc-terraform\\dockers\\image"
  for_each = local.deployment
  image_in = each.value.image
}

module "container" {
  source      = "C:\\Users\\Saif\\Downloads\\Udemy_labs\\mtc-terraform\\dockers\\container"
  count_in    = each.value.container_count
  for_each    = local.deployment
  name_in     = each.key
  image_in    = module.image[each.key].image_out
  int_port_in = each.value.int
  ext_port_in = each.value.ext
  volumes_in  = each.value.volumes
} 