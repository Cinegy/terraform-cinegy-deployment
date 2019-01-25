terragrunt = {
  include {
    path = "${find_in_parent_folders()}"
  }

  terraform {
    source = "git::https://github.com/Cinegy/terraform-cinegy-modules.git//vpc?ref=v0.0.1"
  }
}

cidr_block = "10.120.0.0/16"

public_a_subnet_cidr_block = "10.120.1.0/24" 
public_b_subnet_cidr_block = "10.120.2.0/24"
private_a_subnet_cidr_block = "10.120.101.0/24"
private_b_subnet_cidr_block = "10.120.102.0/24"