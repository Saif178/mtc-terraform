//--------------------------------------------------------------------
// Variables



//--------------------------------------------------------------------
// Modules
module "compute" {
  source  = "app.terraform.io/TDC-178/compute/aws"
  version = "1.0.1"

  aws_region = "us-east-1"
  public_key_material = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDMW5uJwSdHX8Bv9gbCNryoaDLLSTUJQnGuLr2dBe5hkU/91qtyBTh50+G/L1G5asst6eqnLUR8LdDGVoHBmUOb35jjrhju0OYB0Rtyk3NbYSkAEvGjU5LNgtVqGl75PdcTIgGvo9H99ykiwAgVOZFLOWyH/1FaXBWQzS6Urjw8KP1fZuJfnk3jHfgMpoYNZddfJoWAl7yJ+fmjLOgr0D6uM4aeA1h9HknhOoyjsbw18FqwxVSri8dsXSViAVdC38EG7NWH/tC7pUp8fLg5VqOqq0zGLOusowWsRsBPlYHAlN+ywwFG7IRL5dqy5QfSSp/cTpoq5aiwGgma+gDixm4TZ/2H0baPA+KfGOBEdXpn8CncczRqHEtz+TPabFzucFCsFZzRfBBiVzUqdZFbP+LNBzFzK8cIkoj/5FOFfrFKASIDfax9qnA4En6JZwfwGhZYroMuNy3aXPUYrIP//Pv/5PXaJ72P5+bGzWho6N7sfSGVObOyiVmYMUdixVYtmIU= saif@Saif178"
  public_sg = "${module.networking.public_sg}"
  public_subnets = "${module.networking.public_subnets}"
}


module "networking" {
  source  = "app.terraform.io/TDC-178/networking/aws"
  version = "1.0.0"

  access_ip = "0.0.0.0/0"
  aws_region = "us-east-1" 
}