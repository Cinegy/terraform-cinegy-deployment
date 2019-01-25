terragrunt = {
  include {
    path = "${get_tfvars_dir()}/../../../terraform.tfvars"
  }
  dependencies {
    paths = ["../../vpc","../../directoryservice","../../sysadmin"]
  } 
  
  terraform {
    source = "git::https://github.com/Cinegy/terraform-cinegy-modules.git//runpowershellrds?ref=v0.0.1"
  }
}

vm_name_tag_value = "SYSADMIN1A-DEV"
powershell_script_path = "./scripts/create-archive-db.ps1"

template_vars = {
  archive_db_name = "archive_dev_auto"
  rds_sa_username = "sa"
  rds_sa_password = "password!123456789"
}
