output "application_access" {
    value = {for x in docker_container.app_container[*]: x.name => flatten([
        for ip, port in zipmap(x.network_data[*].ip_address, x.ports[*]["external"]) : join(":", [ip, tostring(port)])
    ])}
}