terragrunt = {  
    remote_state {
        backend = "s3" 
        config {
            encrypt = true
            
            #aws_account_id is used here to protect against downstream accidents
            #when an account gets changed unexpectedly.
            #this bucket name is hardcoded downstream in the environment.tfvars
            #which gets included through extra_arguments calls
            bucket = "cinegydemo-terraform-state-${get_aws_account_id()}"
            
            key = "${path_relative_to_include()}/terraform.tfstate"
            region = "eu-west-1"
            dynamodb_table = "cinegydemo-terragrunt-lock-table"
            profile = "terragrunt"

            s3_bucket_tags {
                owner = "terragrunt integration test"
                name  = "Terraform state storage"
            }

            dynamodb_table_tags {
                owner = "terragrunt integration test"
                name  = "Terraform lock table"
            }
        }
    }
    
    terraform {
    extra_arguments "conditional_vars" {
      commands = [
        "apply",
        "plan",
        "import",
        "push",
        "refresh",
        "destroy"
      ]

      optional_var_files = [
          #this path is relative to the deepest tfvar running - so
          #it assumes that the environment is always defined 1 or 2 levels higher
        "${get_tfvars_dir()}/../environment.tfvars",
        "${get_tfvars_dir()}/../../environment.tfvars"
      ]
    }
    
  }

    
}
