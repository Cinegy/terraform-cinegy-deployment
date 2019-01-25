terragrunt = {
  include {
    path = "${get_tfvars_dir()}/../../../terraform.tfvars"
  }
  dependencies {
    paths = ["../../vpc","../../directoryservice","../../sysadmin"]
  } 
  
  terraform {
    source = "git::https://github.com/Cinegy/terraform-cinegy-modules.git//runpowershell?ref=v0.0.1"
  }
}

vm_name_tag_value = "SYSADMIN1A-DEV"
powershell_script_path = "./scripts/install-rsat.ps1"