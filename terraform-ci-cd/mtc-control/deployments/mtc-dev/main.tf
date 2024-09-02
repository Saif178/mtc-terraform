//--------------------------------------------------------------------
// Variables



//--------------------------------------------------------------------
// Modules
module "compute" {
  source  = "app.terraform.io/TDC-178/compute/aws"
  version = "1.0.0"

  aws_region = "us-east-1"
  public_key_material = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC2E9wHA6TgKU0jZQ5Ksyrsfbe3R/eh/nsIV93cN+UWn/EgDPyvYxA8XIZl0sLNW5vgNjQu+0DXEOrfnSedOwTotG4yAwXRY31W/BxDtdRz2jqQCJ02fq84Qfn6oF5YwVBA3Q/Nh/Rcyyj28aFgOtVCKudNRp7q/cbKlgvI6MWSlrG5PwVMiCbE9Ze6ZR97col3uHylvUbPZ7RgRa+i9dnKPldgWfwoYmmqXU/1sN4iF49cfwCIG0syM9kGKIUQhQQ2isKB10ENGT96fWR7Vty9JAwIx35eBTpU/SHmFHzH1yIRp7+tqzAUqlpkN8YEZDXlgo0OcEVsuTkNUQJxGrFagnXtWxE1LfGGbn9boNbY13QVrZDTc/odi7WXs8vGblrnOBBcFdiOikFsrW9tsPDTtrRdh1t6bBYtcBo7ZLEbnX5+hiSRYSxMOXKTpO4bgiAqZMiM3KpPeiAUSMFc9HHQm+24aEanyaOkFffhp9hSEbf45wD5V5XBn7O6r+kPjf0= saif@Saif178"
  public_sg = "${module.networking.public_sg}"
  public_subnets = "${module.networking.public_subnets}"
}


module "networking" {
  source  = "app.terraform.io/TDC-178/networking/aws"
  version = "1.0.0"

  access_ip = "0.0.0.0/0"
  aws_region = "us-east-1" 
}