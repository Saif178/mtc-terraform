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
  sensitive = false
}