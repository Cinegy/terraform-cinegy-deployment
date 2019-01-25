terragrunt = {
  include {
    path = "${find_in_parent_folders()}"
  }
  dependencies {
    paths = ["../vpc","../directoryservice"]
  } 
  
  terraform {
    source = "git::https://github.com/Cinegy/terraform-cinegy-modules.git//basevm-win-cinagent?ref=v0.0.1"
  }
}

aws_subnet_tier = "Public"
aws_subnet_az = "A"
instance_type = "t3.small"
host_name_prefix = "SYSADMIN1A"
host_description = "VPC SysAdmin Instance 1A"
create_external_dns_reference = true

user_data_script_extension = <<EOF

RenameHost
EOF

