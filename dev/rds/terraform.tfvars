terragrunt = {
  include {
    path = "${find_in_parent_folders()}"
  }
  dependencies {
    paths = ["../vpc","../directoryservice"]
  } 
  
  terraform {
    source = "git::https://github.com/Cinegy/terraform-cinegy-modules.git//rds?ref=v0.0.1"
    
  }
}

aws_subnet_tier = "Private"
aws_subnet_az = "*"
rds_instance_class = "db.t2.medium"
rds_multi_az = false
rds_allocated_storage = "20"
rds_skip_final_snapshot = true
mssql_admin_username = "sa"
mssql_admin_password = "password!123456789"
rds_instance_name_prefix = "rds-sqlex13"
create_ad_domain_dns_alias = true
mssql_engine = "sqlserver-ex"
mssql_engine_family = "sqlserver-ex-13.0"
engine_specific_version = "13.00.5216.0.v1"
engine_major_version ="13.00"
