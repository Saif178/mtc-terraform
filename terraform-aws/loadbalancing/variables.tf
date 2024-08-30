#---terraform-aws/loadbalancing/variables.tf---

variable "public_sg" {}
variable "public_subnets" {}

#---load balancer variables---
variable "lb_healthy_threshold" {}
variable "lb_unhealthy_threshold" {}
variable "lb_interval" {}
variable "lb_timeout" {}
variable "vpc_id" {}
variable "tg_port" {}
variable "tg_protocol" {}
variable "listener_port" {}
variable "listener_protocol" {}