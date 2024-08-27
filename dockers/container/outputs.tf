output "application_access" {
  value = { for x in docker_container.app_container[*] : x.name => join(":", [x.network_data[0].ip_address, tostring(x.ports[0].external)]) }
}