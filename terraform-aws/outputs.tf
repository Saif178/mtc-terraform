#---terraform-aws/outputs.tf---

output "load_balancer_endpoint" {
    value = module.loadbalancing.lb_endpoint
}

output "instances" {
    value = {for instance in module.compute.instances: instance.tags.Name => "${instance.public_ip}:${module.compute.instance_port}"}
}