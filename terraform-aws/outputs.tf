#---terraform-aws/outputs.tf---

output "load_balancer_endpoint" {
  value = module.loadbalancing.lb_endpoint
}

output "instances" {
  value     = { for instance in module.compute.instances : instance.tags.Name => "${instance.public_ip}:${module.compute.instance_port}" }
  sensitive = true
}

output "kubeconfig" {
  value     = [for instance in module.compute.instances : "set KUBECONFIG=C:\\Users\\Saif\\Downloads\\k3s-${instance.tags.Name}.yaml"]
  sensitive = true
}