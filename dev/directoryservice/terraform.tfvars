terragrunt = {
  include {
    path = "${find_in_parent_folders()}"
  }
  dependencies {
    paths = ["../vpc", "../iam"]
  } 
  
  terraform {
    source = "git::https://github.com/Cinegy/terraform-cinegy-modules.git//directoryservice?ref=v0.0.5"
  }
}

